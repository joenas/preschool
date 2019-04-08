class Api::PreschoolsController < ApiController

  def index
    view = Preschools::OpenToday.new(params: params, sorting: :api)
    data = {
      preschools: view,
      hours: view.hours,
    }
    respond_with_resource data
  end
end
