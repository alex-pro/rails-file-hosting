class Address < ActiveRecord::Base
  validates :country, length: { maximum: 25 }
  validates :city, length: { maximum: 25 }
  validates :street, length: { maximum: 30 }
  validates :house_number, length: { maximum: 10 }
  belongs_to :profile
end
