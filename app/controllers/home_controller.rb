class HomeController < ApplicationController

  def index
    @view = Preschools::OpenToday.new(params: params, scope: Preschool.includes(:hours))
  end
end
