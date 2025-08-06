require 'test_helper'

module Api
  module V1
    class PaymentsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @payment = payments(:one)
        @valid_payment_params = {
          customer_name: 'John Doe',
          card_number: '4111111111111111',
          card_expiration: '12/25',
          address: '123 Main St, City, State 12345',
          amount_in_cents: 5000
        }
      end

      test 'should get index' do
        Payment.create!(
          iticalc_id: 'test_id_3',
          customer_name: 'Bob Johnson',
          amount_in_cents: 10_000,
          card_last_four: 3333,
          payment_status: 'success'
        )

        get api_v1_payments_url, as: :json
        assert_response :success

        payments = JSON.parse(response.body)
        assert_equal 3, payments.length
      end

      test 'should show payment' do
        get api_v1_payment_url(@payment), as: :json
        assert_response :success

        payment_data = JSON.parse(response.body)
        assert_equal @payment.id, payment_data['id']
        assert_equal @payment.customer_name, payment_data['customer_name']
      end

      test 'should return 404 for non-existent payment' do
        get api_v1_payment_url(99_999), as: :json
        assert_response :not_found
      end

      test 'should create payment with valid params' do
        assert_difference('Payment.count') do
          post api_v1_payments_url, params: @valid_payment_params, as: :json
        end

        assert_response :created

        payment_data = JSON.parse(response.body)
        assert_equal @valid_payment_params[:customer_name], payment_data['customer_name']
        assert_equal @valid_payment_params[:amount_in_cents], payment_data['amount_in_cents']
      end

      test 'should handle payment creation with missing params' do
        incomplete_params = @valid_payment_params.except(:customer_name)

        post api_v1_payments_url, params: incomplete_params, as: :json
        assert_response :unprocessable_entity
      end

      test 'should update payment status to refund' do
        patch api_v1_payment_url(@payment), params: { status: 'refund' }, as: :json
        assert_response :success

        payment_data = JSON.parse(response.body)
        assert_equal 'refund', payment_data['payment_status']
      end

      test 'should update payment status to fail' do
        patch api_v1_payment_url(@payment), params: { status: 'fail' }, as: :json
        assert_response :success

        payment_data = JSON.parse(response.body)
        assert_equal 'fail', payment_data['payment_status']
      end

      test 'should update payment status to success' do
        @payment.update!(payment_status: 'fail')

        patch api_v1_payment_url(@payment), params: { status: 'success' }, as: :json
        assert_response :success

        payment_data = JSON.parse(response.body)
        assert_equal 'success', payment_data['payment_status']
      end
    end
  end
end
