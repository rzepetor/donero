class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  add_flash_types :success, :danger

  before_action :authenticate

  private

  def authenticate
    http_basic_authenticate_or_request_with(name: ENV.fetch("BASIC_AUTH_USERNAME"), password: ENV.fetch("BASIC_AUTH_PASSWORD"))
  end
end
