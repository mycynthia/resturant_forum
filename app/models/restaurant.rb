class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category, optional: true
  # 當Restaruant 物件被刪除時，順便出除依賴的Comment
  has_many :comments, dependent: :destroy
  # 餐廳被許多使用者收藏
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

end
