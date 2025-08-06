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

  def authorize_payment_access!(payment)
    render json: { errors: ['Forbidden'] }, status: :forbidden unless payment_accessible?(payment)
  end

  def payment_accessible?(_payment)
    # Authorization logic goes here.

    true
  end
end
