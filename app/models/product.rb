class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :item_id, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
