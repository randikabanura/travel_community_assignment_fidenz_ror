class Trip < ApplicationRecord
  validates :location, presence: true
  validates_length_of :photos, maximum: 5
  validate :image_type, if: :location_changed?

  def thumbnail(input, size =100)
    return self.photos[input].variant(resize: "#{size}x#{size}!").processed
  end
  geocoded_by :location
  after_validation :geocode

  has_many_attached :photos
  belongs_to :user

  private

  def image_type
    if photos.attached? == true
      photos.each do |photo|
        if !photo.content_type.in?(%('image/jpeg image/png'))
          errors.add(:photos, 'needs to be a JPEG or PNG')
        end
      end
    end
  end
end
