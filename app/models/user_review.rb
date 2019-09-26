class UserReview < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :review_user, class_name: 'User'

  attr_accessor :user_id
  attr_accessor :review_user_id

  acts_as_commontable dependent: :destroy
end
