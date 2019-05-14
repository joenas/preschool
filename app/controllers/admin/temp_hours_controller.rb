class Admin::TempHoursController < AdminController

  def create
    Resources::Create.new(klass: TempHour, params: create_params, listeners: [self]).perform
  end

  def create_success(resource, _params)
    redirect_to admin_preschool_path(resource.preschool)
  end

  def create_failure(resource, _params)
    flash[:error] = resource.errors.full_messages
    redirect_to admin_preschool_path(id: _params[:preschool_id])
  end

  def destroy
    hour = TempHour.find(params[:id])
    preschool = hour.preschool
    hour.destroy
    redirect_to admin_preschool_path(preschool)
  end

  private

  def create_params
    permitted = params.permit(:preschool_id, temp_hour: [:closed_for_day, :opens_at, :closes_at])
    permitted[:temp_hour].merge(preschool_id: params[:preschool_id])
  end

end
