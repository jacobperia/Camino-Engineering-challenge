class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :iticalc_id
      t.string :name
      t.string :amount_in_cents
      t.integer :last_four
      t.string :status

      t.timestamps
    end
  end
end
