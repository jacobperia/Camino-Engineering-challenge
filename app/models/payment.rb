class Payment < ApplicationRecord
  validates_presence_of :iticalc_id, :customer_name, :amount_in_cents, :card_last_four, :payment_status
  validates_inclusion_of :payment_status, in: %w[success fail refund]
end
