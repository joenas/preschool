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

    private

    def with_todays_hours
      @scope.find_by_sql(with_todays_hours_query)
    end

    def with_todays_hours_query
      <<-EOF
      WITH data AS (
        SELECT
          preschool_id,
          make_timestamp(date_part('year', NOW())::int,date_part('month', NOW())::int,date_part('day', NOW())::int,date_part('hours', hours.closes)::int,date_part('minutes', hours.closes)::int,0) #{timezone_cast} as closes,
          hours.opens <= (now() #{timezone_cast})::time AND hours.closes >= (now() #{timezone_cast})::time AS is_open
        FROM hours
        WHERE true
          AND hours.day_of_week = extract(dow from current_date)
      )
      SELECT
      preschools.*,
      #{position_query_select}
      data.closes,
      COALESCE(data.is_open, false) as is_open
      FROM preschools
      LEFT JOIN data ON data.preschool_id = preschools.id AND data.is_open
      WHERE true

      ORDER BY #{position_query_order_by} COALESCE(data.is_open, false) DESC, data.closes DESC
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
