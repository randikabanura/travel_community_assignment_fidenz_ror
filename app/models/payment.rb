class Payment < ApplicationRecord
  before_create :set_expiration_date

  belongs_to :user

  def set_expiration_date
    self.exp_date =  Time.now + 30.days
  end
end
