class PreschoolUrl < ActiveRecord::Base

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :url
  validates_presence_of :hours_element
  validates_presence_of :extras_element

  def url_short
    url.split("/").last(2).join("/")
  end

end
