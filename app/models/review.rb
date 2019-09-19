class Review < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  attr_accessor :user_id
  attr_accessor :trip_id

  acts_as_commontable dependent: :destroy
end
