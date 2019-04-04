class Api::PreschoolsController < ApiController

  def index
    view = Preschools::OpenToday.new(params: params, sorting: :api)
    data = {
      preschools: view,
      hours_today: view.hours_today,
      hours_tomorrow: view.hours_tomorrow
    }
    render json: data
  end
end
