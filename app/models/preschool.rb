class Preschool < ActiveRecord::Base

  has_many :hours

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :street_name
  validates_presence_of :postal_code
  validates_presence_of :city

  scope :with_todays_hours, ->{
    find_by_sql(with_todays_hours_query)
  }

  private

  def self.with_todays_hours_query
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
    data.closes,
    COALESCE(data.is_open, false) as is_open
    FROM preschools
    LEFT JOIN data ON data.preschool_id = preschools.id AND data.is_open
    WHERE true

    ORDER BY COALESCE(data.is_open, false) DESC, data.closes DESC
    EOF
  end

  def self.timezone_cast
    "AT TIME ZONE '#{Time.zone.name}'"
  end
end
