class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_many :folders, dependent: :destroy
  has_many :items, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_create :build_profile

  def build_profile
    Profile.create(user: self, birthday: Time.now)
  end
end
