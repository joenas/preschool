class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USERNAME'], password: ENV['HTTP_PASSWORD']
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, if: :json_request?
end
