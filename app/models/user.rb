class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_followable
  acts_as_follower
  acts_as_commontator

  after_create :assign_default_role
  validates :name, :email, presence: true
  validate :image_type
  validates_length_of :images, maximum: 5
  validate :avatar_type

  has_one_attached :avatar
  has_many_attached :images
  has_many :trips, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :created_user_reviews, class_name: 'UserReview', foreign_key: 'user'
  has_many :having_user_reviews, class_name: 'UserReview', foreign_key: 'review_user'

  scope :admins, -> { User.with_role(:admin) }
  scope :pro_user_1, -> { User.with_role(:pro_user_1) }
  scope :pro_user_2, -> { User.with_role(:pro_user_2) }
  scope :pro_user_3, -> { User.with_role(:pro_user_3) }
  scope :normal, -> { User.with_role(:normal)  }

  def thumbnail input
    return self.images[input].variant(resize: '200x200!').processed
  end

  def self.search(search)
    if search
      User.without_role(:admin).where('name LIKE ?', "%#{search}%").to_a
    else
      User.without_role(:admin).to_a
    end
  end

  def average_rating
    reviews = self.having_user_reviews
    if reviews.count > 0
      reviews.sum(:rating) / reviews.count
    else
      return 0
    end
  end

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

  def avatar_type
    if avatar.attached? == true
      if !avatar.content_type.in?(%('image/jpeg image/png'))
        errors.add(:avatar, 'needs to be a JPEG or PNG')
      end
    end
  end

  def assign_default_role
    add_role(:normal) if self.roles.blank?
  end
end
