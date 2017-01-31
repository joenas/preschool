class SiteChange < ActiveRecord::Base
  extend Enumerize

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :data

  enumerize :state, in: [:new, :active, :done], default: :new

end
