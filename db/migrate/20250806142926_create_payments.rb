class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :iticalc_id
      t.string :customer_name
      t.integer :amount_in_cents
      t.integer :card_last_four
      t.string :payment_status

      t.timestamps
    end
  end
end
