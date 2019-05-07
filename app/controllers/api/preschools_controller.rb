class Api::PreschoolsController < ApiController

  def index
    view = Preschools::OpenToday.new(params: params)
    data = {
      preschools: view,
      hours: view.hours,
    }
    respond_with_resource data
  end
end
