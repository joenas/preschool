class HomeController < ApplicationController

  def index
    @view = Preschools::OpenToday.new(params: params)
  end
end
