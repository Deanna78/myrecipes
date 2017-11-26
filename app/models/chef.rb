class Chef < ApplicationRecord
  before_save { self.email = email.downcase }
  before_save :normalise_chefname, on: :create

  validates :chefname, presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 100 },
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
  has_many :recipes
  has_secure_password
  validates :password, presence: true, length: {minimum: 5 }, allow_nil: true


  private

  def normalise_chefname
    self.chefname = chefname.downcase.titleize
  end



end
