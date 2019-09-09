class Trip < ApplicationRecord
  validates :location, presence: true
  validate :image_type, if: :location_changed?

  geocoded_by :location
  after_validation :geocode

  has_many_attached :photos
  belongs_to :user

  private

  def image_type
    if photos.attached? == true
      photos.each do |photo|
        print "image"
        if !photo.content_type.in?(%('image/jpeg image/png'))
          errors.add(:photos, 'needs to be a JPEG or PNG')
        end
      end
    end
  end
end
