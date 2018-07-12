class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category, optional: true
  # 當Restaruant 物件被刪除時，順便出除依賴的Comment
  has_many :comments, dependent: :destroy
end
