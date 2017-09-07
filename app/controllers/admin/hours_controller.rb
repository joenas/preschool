class Admin::HoursController < AdminController

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

  private

  def update_params
    permitted = params.permit(:id, hour: [:opens, :closes])
    permitted[:hour].merge(id: params[:id])
  end


end
