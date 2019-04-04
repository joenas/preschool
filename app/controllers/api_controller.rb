class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?

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
