class Hour < ActiveRecord::Base

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :day_of_week
  validates_presence_of :opens
  validates_presence_of :closes

  scope :today, -> {
    where("day_of_week = extract(dow from current_date)")
    .order(opens: :asc, closes: :asc)
  }

  scope :regular, -> {
    where(note: nil)
  }

  scope :non_regular, -> {
    where.not(note: nil)
  }

  # Goddamn this is annoying
  def open?
    (opens..closes).include? Now.new
  end

  def opens_short
    I18n.l(opens, format: :short)
  end

  def closes_short
    I18n.l(closes, format: :short)
  end

end
