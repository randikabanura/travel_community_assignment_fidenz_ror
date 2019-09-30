class AddExpDateToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :exp_date, :date
  end
end
