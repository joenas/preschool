class TempHour < ActiveRecord::Base

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :opens_at
  validates_presence_of :closes_at

  default_scope { order(opens_at: :desc, closes_at: :desc) }

  scope :this_year, -> {where("extract(year from (opens_at #{timezone_cast})) = extract(year from (now() #{timezone_cast}))")}

  def self.timezone_cast
    "AT TIME ZONE '#{Time.zone.name}'"
  end

  ### Logics
  def today?
    opens_at.wday == Time.now.wday
  end

  ### Presentation
  def day_and_date
    I18n.l(opens_at, format: :temp_hour_date)
  end

  def opens_at_short
    I18n.l(opens_at, format: :short)
  end

  def closes_at_short
    I18n.l(closes_at, format: :short)
  end

end
