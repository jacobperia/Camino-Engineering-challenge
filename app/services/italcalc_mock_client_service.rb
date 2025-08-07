class ItalcalcMockClientService
  def initialize
    # Leaving the API keys here for the sake of simplicity. In a real app, they should be stored in an environment variable.
    @private_key = 'private_41455'
    @public_key = 'public_11114'
  end

  def create_payment(params)
    {
      id: SecureRandom.hex(10),
      name: params[:name],
      amount_in_cents: params[:amount_in_cents],
      last_four: params[:card_number][-4..],
      status: 'success'
    }
  end

  def refund_payment(id)
    { id: id, status: 'Refunded' }
  end
end
