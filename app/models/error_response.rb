# ErrorResponse model for consistent error responses
class ErrorResponse
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :errors

  validates :errors, presence: true

  def initialize(errors = [])
    @errors = errors.is_a?(Array) ? errors : [errors]
  end

  def to_hash
    {
      errors: errors
    }
  end
end 