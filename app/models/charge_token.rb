# A token to be used in the creation of payment.
class ChargeToken
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :token

  validates :token, presence: true

  def to_hash
    {
      token: token
    }
  end
end 