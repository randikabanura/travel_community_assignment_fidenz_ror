class User < ApplicationRecord
  rolify

  after_create :assign_default_role
  validates :name, :email, presence: true
  validate :image_type
  validates_length_of :images, maximum: 5
  validate :avatar_type

  def thumbnail input
    return self.images[input].variant(resize: '200x200!').processed
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_followable
  acts_as_follower
  acts_as_commontator
  has_one_attached :avatar
  has_many_attached :images
  has_many :trips, dependent: :destroy
  has_many :reviews, dependent: :destroy
  scope :admins, -> { Role.find_by_name('admin').users}
  scope :pro_users, -> { Role.find_by_name('pro_user').users}
  scope :normal, -> { Role.find_by_name('normal').users}

  def self.search(search)
    if search
      Role.find_by(name: 'normal').users.or(Role.find_by(name: 'pro_user').users).where('name LIKE ?', "%#{search}%").to_a
    else
      Role.find_by(name: 'normal').users.or(Role.find_by(name: 'pro_user').users)
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
