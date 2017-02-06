class Hour < ActiveRecord::Base

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :day_of_week
  validates_presence_of :opens
  validates_presence_of :closes

  default_scope { order(day_of_week: :asc, opens: :asc, closes: :asc) }

  scope :today, -> {
    where("day_of_week = extract(dow from current_date)")
  }

  scope :tomorrow, -> {
    where("day_of_week = extract(dow from current_date)+1")
  }

  # Goddamn this is annoying
  def open?
    (opens..closes).include?(Now.new) && today?
  end

  def today?
    day_of_week == Time.now.wday
  end

  def day_name
    I18n.t('date.day_names')[day_of_week]
  end

  def opens_short
    I18n.l(opens, format: :short)
  end

  def closes_short
    I18n.l(closes, format: :short)
  end

end
