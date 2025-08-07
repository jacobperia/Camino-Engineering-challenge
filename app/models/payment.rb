# Payment model
class Payment < ApplicationRecord
  validates_presence_of :iticalc_id, :amount_in_cents, :last_four, :name, :status
  validates_inclusion_of :status, in: %w[Succeeded Failed Refunded]

  enum status: { succeeded: 'Succeeded', failed: 'Failed', refunded: 'Refunded' }
end
