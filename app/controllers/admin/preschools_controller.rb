class Admin::PreschoolsController < AdminController
  layout 'admin'

  def index; end

  def show
    @tab = params.fetch(:tab, :hours).to_sym
    @view = Preschool.find(params[:id])
  end

end
