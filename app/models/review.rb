class Review < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :trip_id

  belongs_to :user
  belongs_to :trip

  attr_accessor :user_id
  attr_accessor :trip_id

  validates :rating, presence: true

  acts_as_commontable dependent: :destroy
end
