class Admin::SiteChangesController < AdminController

  def index; end

  def create
    Resources::Create.new(klass: SiteChange, params: create_params, listeners: [self, Listeners::PostNewSiteChangeToSlack.new]).perform do |change|
      change.preschool = Preschool.find_by_id(params[:preschool_id])
      if change.note_prediction
        change.attributes = {note: change.note_prediction, state: :active}
      end
    end
  end

  def create_success(resource, _params)
    respond_with_resource(resource)
  end

  def create_failure(resource, _params)
    respond_with_failure(resource.errors)
  end

  def update
    Resources::Update.new(klass: SiteChange, params: update_params, listeners: [self, Listeners::TrainNewSiteChange.new]).perform
  end

  def update_success(resource, _params)
    redirect_to admin_preschool_path(resource.preschool)
  end

  def update_failure(resource, _params)
    flash[:error] = resource.errors.full_messages
    redirect_to admin_preschool_path(resource.preschool)
  end

  private

  def create_params
    params.permit(:preschool_id, data: [:hours, :extra])
  end

  def update_params
    permitted = params.permit(:id, site_change: [:state, :note])
    permitted[:site_change].merge(id: params[:id])
  end

end
