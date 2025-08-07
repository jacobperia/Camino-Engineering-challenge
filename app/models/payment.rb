# Payment model
class Payment < ApplicationRecord
  validates_presence_of :amount_in_cents, :last_four, :name, :status
  validates_inclusion_of :status, in: %w[Succeeded Failed Refunded]
end
