module Api
  module V1
    class ChargeTokenController < ApplicationController
      def charge_token
        charge_token = ChargeToken.new(token: SecureRandom.hex)
        render json: charge_token
      end
    end
  end
end
