class Admin::ChangesController < AdminController

  def index; end

  def create
    permitted = params.permit(:preschool_id, data: [:text, :extra])
    CreateResource.new(klass: Change, params: permitted, listener: self).perform do |change|
      change.preschool = Preschool.find_by_id(params[:preschool_id])
    end
  end

  def create_success(resource, _params)
    respond_with_resource(resource)
  end

  def create_failure(resource, _params)
    respond_with_failure(resource.errors)
  end

end
