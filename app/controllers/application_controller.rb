class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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