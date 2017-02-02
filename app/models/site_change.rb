class SiteChange < ActiveRecord::Base
  extend Enumerize

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :data

  enumerize :state, in: [:new, :active, :done], default: :new

  scope :recent, -> {where(state: :new)}

  def new_or_active?
    state.to_sym.in?([:new, :active])
  end

  def note_html
    note.gsub("\n", "<br>").html_safe
  end

end
