class Admin::SiteChangesController < AdminController

  def index; end

  def create
    permitted = params.permit(:preschool_id, data: [:hours, :extra])
    CreateResource.new(klass: SiteChange, params: permitted, listener: self).perform do |change|
      change.preschool = Preschool.find_by_id(params[:preschool_id])
    end
  end

  def create_success(resource, _params)
    respond_with_resource(resource)
  end

  def create_failure(resource, _params)
    respond_with_failure(resource.errors)
  end

  def update
    permitted = params.permit(:id, :state, :note)
    UpdateResource.new(klass: SiteChange, params: permitted, listener: self).perform
  end

  def update_success(resource, _params)
    redirect_to admin_preschool_path(resource.preschool)
  end

  def update_failure(resource, _params)
    flash[:error] = resource.errors.full_messages
    redirect_to admin_preschool_path(resource.preschool)
  end

end
