class Hour < ActiveRecord::Base

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :day_of_week
  validates_presence_of :opens
  validates_presence_of :closes

  #validates :opens, format: { with: /\A\d{2}:\d{2}\z/, message: "Format hh:mm" }
  #validates :closes, format: { with: /\A\d{2}:\d{2}\z/, message: "Format hh:mm" }

  default_scope { order(day_of_week: :asc, opens: :asc, closes: :asc) }

  scope :today, -> {
    where("day_of_week = extract(dow from (now() #{timezone_cast}))")
  }

  scope :tomorrow, -> {
    where("day_of_week = extract(dow from (now() #{timezone_cast}))+1")
  }

  def self.timezone_cast
    "AT TIME ZONE '#{Time.zone.name}'"
  end

  ### Logics
  def open?
    today? && (opens_at..closes_at).cover?(Time.current.strftime("%H:%M"))
  end

  def today?
    day_of_week == Time.now.wday
  end

  def opens_at
    opens.strftime("%H:%M")
  end

  def closes_at
    closes.strftime("%H:%M")
  end

  ### Presentation
  def day_name
    I18n.t('date.day_names')[day_of_week]
  end

  def opens_short
    I18n.l(opens, format: :short)
  end

  def closes_short
    I18n.l(closes, format: :short)
  end

  ### Meta data
  def closes_json_ld
    I18n.l(closes, format: :json_ld)
  end

  def opens_json_ld
    I18n.l(opens, format: :json_ld)
  end

  def dow_json_ld
    I18n.t('date.day_names', locale: :en)[day_of_week]
  end

  def to_json_ld
    {
      "@type" => "OpeningHoursSpecification",
      "closes" => closes_json_ld,
      "dayOfWeek" => "http://schema.org/#{dow_json_ld}",
      "opens" => opens_json_ld
    }
  end

end
