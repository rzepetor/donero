class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |token|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch("API_TOKEN"))
    end
  end
end
