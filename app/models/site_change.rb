class SiteChange < ActiveRecord::Base
  extend Enumerize

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :data

  enumerize :state, in: [:new, :active, :done], default: :new

  def new_or_active?
    state.to_sym.in?([:new, :active])
  end

end
