class Folder < ActiveRecord::Base
  validates :name, presence: true
  has_many :children, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
  has_many :items, dependent: :destroy
  belongs_to :parent, class_name: "Folder"
  belongs_to :user
end
