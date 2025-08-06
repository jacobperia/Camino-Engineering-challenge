module Api
  module V1
    # Handles all payments related requests and communicates with Iticalc API
    class PaymentsController < ApplicationController
      def index
        @pagy, @payments = pagy(Payment.all, items: params[:per_page], page: params[:page])
        render json: @payments
      end

      def show
        payment = Payment.find(params[:id])
        render json: payment
      end

      def create
        # Simulate external call to Iticalc API
        result = ItalcalcMockClientService.new.create_payment(payment_params)

        payment = Payment.create!(
          iticalc_id: result[:id],
          customer_name: result[:name],
          amount_in_cents: result[:amount_in_cents],
          card_last_four: result[:last_four],
          payment_status: result[:status]
        )

        render json: payment, status: :created
      end

      def update
        payment = Payment.find(params[:id])
        if payment.update(payment_status: params[:status])
          render json: payment
        else
          render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def payment_params
        params.permit(:customer_name, :card_number, :card_expiration, :address, :amount_in_cents)
      end
    end
  end
end
