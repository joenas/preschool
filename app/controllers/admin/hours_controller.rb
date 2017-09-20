class Admin::HoursController < AdminController

  def create
    Resources::Create.new(klass: Hour, params: create_params, listeners: [self]).perform
  end

  def create_success(resource, _params)
    redirect_to admin_preschool_path(resource.preschool)
  end

  def create_failure(resource, _params)
    flash[:error] = resource.errors.full_messages
    redirect_to admin_preschool_path(id: _params[:preschool_id])
  end

  def update
    Resources::Update.new(klass: Hour, params: update_params, listeners: [self]).perform do |hour|
      puts update_params.key?('closes')
      hour.opens = hour.opens_short unless update_params.key?('opens')
      #hour.closes = hour.closes_short# unless update_params.key?('closes')
    end
  end

  def update_success(resource, _params)
    respond_with_bip(resource)
  end

  def update_failure(resource, _params)
    respond_with_bip(resource)
  end

  def destroy
    hour = Hour.find(params[:id])
    preschool = hour.preschool
    hour.destroy
    redirect_to admin_preschool_path(preschool)
  end

  private

  def create_params
    permitted = params.permit(:preschool_id, hour: [:day_of_week, :opens, :closes, :note])
    permitted[:hour].merge(preschool_id: params[:preschool_id])
  end

  def update_params
    permitted = params.permit(:id, hour: [:opens, :closes, :note])
    permitted[:hour].merge(id: params[:id])
  end


end
