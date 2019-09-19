class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :trip, foreign_key: true
      t.integer :rating
      t.string :description

      t.timestamps
    end
  end
end
