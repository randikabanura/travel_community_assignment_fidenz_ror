class AddPlanToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :plan, :integer
  end
end
