class AddColoumsToUserReview < ActiveRecord::Migration[5.2]
  def change
    add_column :user_reviews, :rating, :integer
    add_column :user_reviews, :description, :string
  end
end
