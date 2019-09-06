class Trip < ApplicationRecord
  validates :location, presence: true

  has_one_attached :photos
  belongs_to :user
end
