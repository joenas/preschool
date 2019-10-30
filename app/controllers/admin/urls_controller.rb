class Admin::UrlsController < AdminController

  def update
    Resources::Update.new(klass: PreschoolUrl, params: update_params, listeners: [self]).perform
  end

  def update_success(resource, _params)
    respond_with_bip(resource)
  end

  def update_failure(resource, _params)
    respond_with_bip(resource)
  end

  private

  def update_params
    permitted = params.permit(:id, :preschool_id, preschool_url: [:url, :hours_element, :extras_element, :error_on_check])
    permitted[:preschool_url].merge(id: params[:id])
  end

end
