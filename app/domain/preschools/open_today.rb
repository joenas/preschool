module Preschools
  class OpenToday < SimpleDelegator

    ENGLISH_MILE = 1609

    def initialize(params: {}, scope: Preschool)
      @params = params
      @scope = scope
      super with_todays_hours
    end

    def position?
      latitude && longitude
    end

    def current_time
      @current_time ||= Now.new
    end

    def hours_today
      @hours_today ||= Hour.today.group_by(&:preschool_id)
    end

    def hours_tomorrow
      @hours_tomorrow ||= Hour.tomorrow.group_by(&:preschool_id)
    end

    private

    def with_todays_hours
      @scope.find_by_sql(with_todays_hours_query)
    end

    def with_todays_hours_query
      <<-EOF
      WITH data AS (
        SELECT
          preschool_id,
          hours.closes,
          hours.opens <= (now() #{timezone_cast})::time AND hours.closes >= (now() #{timezone_cast})::time AS is_open
        FROM hours
        WHERE true
          AND hours.day_of_week = extract(dow from current_date)
      ),
      active_site_changes AS (
        SELECT
          preschool_id,
          note
        FROM site_changes
        WHERE true
          AND state = 'active'
        ORDER BY created_at DESC
      ),
      todays_hours AS (
        SELECT
          preschool_id,
          MAX(closes) < (now() #{timezone_cast})::time AS closed_for_day
        FROM hours
        WHERE true
          AND hours.day_of_week = extract(dow from current_date)
        GROUP BY preschool_id
      ),
      multiple_hours AS (
        SELECT
          preschool_id,
          MIN(opens) as opens_again
        FROM hours
        WHERE true
          AND hours.day_of_week = extract(dow from current_date)
          AND hours.opens > (now() #{timezone_cast})::time
        GROUP BY preschool_id
      )
      SELECT
      preschools.*,
        #{position_query_select}
        data.closes,
        COALESCE(data.is_open, false) as is_open,
        COALESCE(todays_hours.closed_for_day, true) AS closed_for_day,
        multiple_hours.opens_again,
        active_site_changes.note AS active_site_changes_note
      FROM preschools
      LEFT JOIN data ON data.preschool_id = preschools.id AND data.is_open
      LEFT JOIN active_site_changes ON active_site_changes.preschool_id = preschools.id
      LEFT JOIN todays_hours ON todays_hours.preschool_id = preschools.id
      LEFT JOIN multiple_hours ON multiple_hours.preschool_id = preschools.id
      WHERE true
      ORDER BY #{position_query_order_by} COALESCE(data.is_open, false) DESC, data.closes DESC, multiple_hours.opens_again ASC, preschools.name ASC
      EOF
    end

    def latitude
      Float(@params['latitude'].presence) rescue nil
    end

    def longitude
      Float(@params['longitude'].presence) rescue nil
    end

    def position_query
      "((preschools.position <@> '(#{latitude},#{longitude})')*#{ENGLISH_MILE})::integer" if position?
    end

    def position_query_order_by
      "#{position_query} ASC,"  if position?
    end

    def position_query_select
      "#{position_query} as distance," if position?
    end

    def timezone_cast
      "AT TIME ZONE '#{Time.zone.name}'"
    end
  end
end
