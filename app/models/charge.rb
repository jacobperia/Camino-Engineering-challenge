# Method of payment that was charged
class Charge
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :cc_number, :cc_expiration, :name, :address

  validates :cc_number, presence: true
  validates :cc_expiration, presence: true
  validates :name, presence: true
  validates :address, presence: true

  def to_hash
    {
      cc_number: cc_number,
      cc_expiration: cc_expiration,
      name: name,
      address: address
    }
  end
end 