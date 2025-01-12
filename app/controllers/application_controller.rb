class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  #added the 2 below to all for POST calls
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

rescue_from ActiveRecord::RecordNotFound, with:
  :garden_not_found

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerializer.format_errors([ e.message ]), status: :unprocessable_entity
  end

  private

  def garden_not_found
    render json: { error: "Garden not found" }, status: :not_found
  end

end