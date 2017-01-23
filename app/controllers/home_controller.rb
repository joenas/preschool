class HomeController < ApplicationController

  def index
    @view = Preschool.includes(:hours).with_todays_hours
  end
end
