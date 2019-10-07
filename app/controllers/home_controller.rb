class HomeController < ApplicationController
  def index
    @view = Preschools::OpenToday.new(params: params)
  end

  def position
    redirect_to root_path, status: :moved_permanently
  end
end
