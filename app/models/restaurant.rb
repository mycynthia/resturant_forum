class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category, optional: true
  # 當Restaruant 物件被刪除時，順便出除依賴的Comment
  has_many :comments, dependent: :destroy
  # 餐廳被許多使用者收藏
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  # 餐廳被許多使用者喜歡
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  def is_liked?(user)
    self.liked_users.include?(user)
  end
  # 使用counter_cache取代，到favorite.rb belong_to後方加上counter_cache
  # def count_favorites
  #   self.favorites_count = self.favorites.size
  #   self.save
  # end

end
