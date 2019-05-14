module Preschools
  class OpenToday < SimpleDelegator

    ENGLISH_MILE = 1609

    def initialize(params: {}, scope: Preschool, sorting: :default)
      @params = params
      @scope = scope
      @sorting = sorting
      super with_todays_hours
    end

    def api?
      @sorting == :api
    end

    def position?
      !api? && latitude && longitude
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

    def current_time_db
      current_time.to_s(:db)
    end

    def current_time_utc_db
      current_time.utc.to_s(:db)
    end


    def current_date
      Date.current
    end

    def with_todays_hours_query
      <<-EOF
      WITH sort_data AS (
        WITH inner_data AS (
          WITH data AS (
            SELECT
              preschool_id,
              hours.closes,
              hours.opens <= '#{current_time_db}'::time AND hours.closes >= '#{current_time_db}'::time AS is_open
            FROM hours
            WHERE true
              AND hours.day_of_week = extract(dow from '#{current_date}'::date)
          ),
          todays_hours AS (
            SELECT
              preschool_id,
              MAX(closes) < '#{current_time_db}'::time AS closed_for_day
            FROM hours
            WHERE true
              AND hours.day_of_week = extract(dow from '#{current_date}'::date)
            GROUP BY preschool_id
          ),
          multiple_hours AS (
            SELECT
              preschool_id,
              MIN(('#{current_date}'::date + opens) #{timezone_cast}) as opens_again
            FROM hours
            WHERE true
              AND hours.day_of_week = extract(dow from '#{current_date}'::date)
              AND hours.opens > '#{current_time_db}'::time
            GROUP BY preschool_id
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
          )
          SELECT
            preschools.*,
            #{position_query_select}
            ('#{current_date}'::date + data.closes) #{timezone_cast} as regular_closes,
            data.is_open as regular_is_open,
            todays_hours.closed_for_day AS regular_closed_for_day,
            multiple_hours.opens_again as regular_opens_again,
            active_site_changes.note AS active_change_note,
            predicted_site_changes.note AS predicted_change_note,
            (active_site_changes.note IS NOT NULL OR predicted_site_changes.note IS NOT NULL) as has_changes
          FROM preschools
          LEFT JOIN data ON data.preschool_id = preschools.id AND data.is_open
          LEFT JOIN todays_hours ON todays_hours.preschool_id = preschools.id
          LEFT JOIN multiple_hours ON multiple_hours.preschool_id = preschools.id
          LEFT JOIN active_site_changes ON active_site_changes.preschool_id = preschools.id AND active_site_changes.rank = 1
          LEFT JOIN predicted_site_changes ON predicted_site_changes.preschool_id = preschools.id AND predicted_site_changes.rank = 1
          WHERE true
        )
        SELECT
          inner_data.*,
          temp_hours.id IS NOT NULL as has_temp_hours,
          COALESCE(temp_hours.closes_at, regular_closes) as closes,
          COALESCE(temp_hours.opens_at, regular_opens_again) as opens_again,
          CASE WHEN temp_hours.closed_for_day THEN FALSE ELSE COALESCE((temp_hours.opens_at <= '#{current_time_utc_db}' AND temp_hours.closes_at >= '#{current_time_utc_db}'), regular_is_open, false) END as is_open,
          COALESCE((temp_hours.closed_for_day OR (temp_hours.closes_at < '#{current_time_utc_db}')), regular_closed_for_day, true) AS closed_for_day
        FROM inner_data
        LEFT JOIN temp_hours ON temp_hours.preschool_id = inner_data.id AND '#{current_date}'::date = temp_hours.opens_at::date
      )
      SELECT
        *
      FROM sort_data
      ORDER BY #{position_query_order_by} COALESCE(is_open, false) DESC, closes DESC, opens_again ASC, name ASC
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
