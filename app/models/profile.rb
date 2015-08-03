class Profile < ActiveRecord::Base
  mount_uploader :photo, FileUploader
  validates :name, length: { maximum: 60 }
  validates :birthday, presence: :true
  belongs_to :user
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true
end
