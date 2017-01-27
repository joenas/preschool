class Admin::PreschoolsController < AdminController
  layout 'admin'

  def index; end

  def show
    @view = Preschool.find(params[:id])
  end

end
