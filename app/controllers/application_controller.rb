class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :authenticate_api_key!

  private

  def authenticate_api_key!
    api_key = request.headers['Iticalc-Key']
    # For demo purposes, accept any non-empty API key
    # In production, you would validate against a database or external service
    render json: { errors: ['Unauthorized'] }, status: :unauthorized unless api_key.present?
  end
end
