class User < ApplicationRecord

  validate :image_type
  validates_length_of :images, maximum: 5
  def thumbnail input
    return self.images[input].variant(resize: '200x200!').processed
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_followable
  acts_as_follower
  has_one_attached :avatar
  has_many_attached :images

  private

  def image_type
    if images.attached? == true
      images.each do |image|
        if !image.content_type.in?(%('image/jpeg image/png'))
          errors.add(:images, 'needs to be a JPEG or PNG')
        end
      end
    end
  end
end
