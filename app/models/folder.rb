class Folder < ActiveRecord::Base
  has_many :children, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Folder"
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true
end
