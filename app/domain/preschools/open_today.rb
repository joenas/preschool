module Preschools
  class OpenToday < SimpleDelegator

    ENGLISH_MILE = 1609

    def initialize(params: {}, scope: Preschool)
      @params = params
      @scope = scope
      super with_todays_hours
    end

    def current_time
      DateTime.current
    end

    def hours
      @hours ||= Hour.all.group_by(&:preschool_id)
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
          AND hours.day_of_week = extract(dow from (now() #{timezone_cast}))
      ),
      active_site_changes AS (
        SELECT
          site_changes.*,
          rank() over (partition by site_changes.preschool_id order by updated_at DESC) AS rank
        FROM site_changes
        WHERE true
          AND state = 'active'
      ),
      predicted_site_changes AS (
        SELECT
          site_changes.*,
          rank() over (partition by site_changes.preschool_id order by updated_at DESC) AS rank
        FROM site_changes
        WHERE true
          AND state = 'predicted'
      ),
      todays_hours AS (
        SELECT
          preschool_id,
          MAX(closes) < (now() #{timezone_cast})::time AS closed_for_day
        FROM hours
        WHERE true
          AND hours.day_of_week = extract(dow from (now() #{timezone_cast}))
        GROUP BY preschool_id
      ),
      multiple_hours AS (
        SELECT
          preschool_id,
          MIN((current_date + opens) #{timezone_cast}) as opens_again
        FROM hours
        WHERE true
          AND hours.day_of_week = extract(dow from (now() #{timezone_cast}))
          AND hours.opens > (now() #{timezone_cast})::time
        GROUP BY preschool_id
      )
      SELECT
      preschools.*,
        (current_date + data.closes) #{timezone_cast} as closes,
        COALESCE(data.is_open, false) as is_open,
        COALESCE(todays_hours.closed_for_day, true) AS closed_for_day,
        multiple_hours.opens_again,
        active_site_changes.note AS active_change_note,
        active_site_changes.updated_at AS active_change_updated_at,
        predicted_site_changes.note AS predicted_change_note,
        predicted_site_changes.updated_at AS predicted_change_updated_at,
        (CASE WHEN active_site_changes.note IS NOT NULL OR predicted_site_changes.updated_at IS NOT NULL THEN TRUE ELSE FALSE END) as has_changes
      FROM preschools
      LEFT JOIN data ON data.preschool_id = preschools.id AND data.is_open
      LEFT JOIN active_site_changes ON active_site_changes.preschool_id = preschools.id AND active_site_changes.rank = 1
      LEFT JOIN predicted_site_changes ON predicted_site_changes.preschool_id = preschools.id AND predicted_site_changes.rank = 1
      LEFT JOIN todays_hours ON todays_hours.preschool_id = preschools.id
      LEFT JOIN multiple_hours ON multiple_hours.preschool_id = preschools.id
      WHERE true
      ORDER BY COALESCE(data.is_open, false) DESC, data.closes DESC, multiple_hours.opens_again ASC, preschools.name ASC
      EOF
    end

    def timezone_cast
      "AT TIME ZONE '#{Time.zone.name}'"
    end
  end
end
