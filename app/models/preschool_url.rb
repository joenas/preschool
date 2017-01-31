class PreschoolUrl < ActiveRecord::Base

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :url
  validates_presence_of :hours_element
  validates_presence_of :extras_element

end
