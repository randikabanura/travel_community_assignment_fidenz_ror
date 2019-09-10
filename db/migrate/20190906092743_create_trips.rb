class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.string :description
      t.string :date_s
      t.string :date_e
      t.string :location

      t.timestamps
    end
  end
end
