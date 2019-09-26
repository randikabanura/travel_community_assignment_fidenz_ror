class CreateUserReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reviews do |t|
      t.references :user
      t.references :review_user

      t.timestamps
    end
  end
end
