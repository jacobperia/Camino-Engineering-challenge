module Api
  module V1
    class ReportsController < ApplicationController
      def monthly
        report = Payment.group('date(created_at)').sum(:amount_in_cents).transform_values(&:to_i)

        render json: {data: report}
      end
    end
  end
end
