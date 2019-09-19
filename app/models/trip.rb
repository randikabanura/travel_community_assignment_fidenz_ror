class Trip < ApplicationRecord
  validates :location, presence: true
  validates :date_s, :date_e, presence: true
  validate :image_type, if: :location_changed?

  def thumbnail(size =100)
    return self.photos.variant(resize: "#{size}x#{size}!").processed
  end
  geocoded_by :location
  after_validation :geocode

  has_one_attached :photos
  belongs_to :user
  has_many :reviews

  def avarage_rating
    reviews = self.reviews
    if reviews.count > 0
      reviews.sum(:rating) / reviews.count
    else
      return 0
    end
  end
  private

  def image_type
    if photos.attached? == true
        if !photos.content_type.in?(%('image/jpeg image/png'))
          errors.add(:photos, 'needs to be a JPEG or PNG')
        end
    end
  end
end
