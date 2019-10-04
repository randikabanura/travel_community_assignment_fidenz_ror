class Payment < ApplicationRecord
  before_create :set_expiration_date
  belongs_to :user

  validates :card_number, presence: true
  validates :card_name, presence: true
  validates :code, presence: true
  validates :date_exp, presence: true

  def set_expiration_date
    self.exp_date = Time.now + 30.days
  end
end
