class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.string :card_number
      t.string :card_name
      t.string :date_exp
      t.integer :code

      t.timestamps
    end
  end
end
