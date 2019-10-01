class AddMessagesCountToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :message_count, :integer
  end
end
