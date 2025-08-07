module Api
  module V1
    # Handles all payments related requests and communicates with Iticalc API
    class PaymentsController < ApplicationController
      def index
        @pagy, @payments = pagy(Payment.all, items: params[:per_page], page: params[:page])
        render json: {
          meta: {
            current_page: @pagy.page,
            next_page: @pagy.next,
            prev_page: @pagy.prev,
            total_pages: @pagy.pages,
            total_count: @pagy.count,
            items_per_page: @pagy.items
          },
          data: @payments
        }
      end

      def show
        payment = Payment.find(params[:id])
        authorize_payment_access!(payment)

        render json: {
          id: payment.id,
          amount_in_cents: payment.amount_in_cents,
          last_four: payment.card_last_four.to_s,
          name: payment.customer_name,
          status: payment.payment_status.capitalize
        }
      rescue ActiveRecord::RecordNotFound
        render json: { errors: ['Payment not found'] }, status: :not_found
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
        authorize_payment_access!(payment)

        if payment.update(payment_status: params[:status])
          render json: {
            id: payment.id,
            amount_in_cents: payment.amount_in_cents,
            last_four: payment.card_last_four.to_s,
            name: payment.customer_name,
            status: payment.payment_status.capitalize
          }
        else
          render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { errors: ['Payment not found'] }, status: :not_found
      end

      private

      def payment_params
        params.permit(:customer_name, :card_number, :card_expiration, :address, :amount_in_cents)
      end
    end
  end
end
