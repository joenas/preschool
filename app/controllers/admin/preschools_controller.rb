class Admin::PreschoolsController < AdminController
  layout 'admin'

  def index; end

  def show
    @tab = params.fetch(:tab, :hours).to_sym
    @view = Preschool.find(params[:id])
  end

  def update
    Resources::Update.new(klass: Preschool, params: update_params, listeners: [self]).perform
  end

  def update_success(resource, _params)
    respond_with_bip(resource)
  end

  def update_failure(resource, _params)
    respond_with_bip(resource)
  end

  private

  def update_params
    permitted = params.permit(:id, preschool: [:url])
    permitted[:preschool].merge(id: params[:id])
  end


end
