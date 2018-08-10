class Category < ApplicationRecord
  validates_presence_of :name
  # 如果分類下已有餐廳，就不允許刪除分類(刪除時會拋出error)
  has_many :restaurants, dependent: :restrict_with_error
  # 有關聯物件的話，向擁有者拋出異常
  # has_many :restaurants, dependent: :restrict_with_exception
end
