class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def respond_with_resource(resource, status: :ok)
    render json: resource, status: status
  end

  def respond_with_failure(errors, status: :unprocessable_entity)
    render json: {errors: errors, messages: errors.full_messages}, status: status
  end

  def json_request?
    request.format.json?
  end

end
