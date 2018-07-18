class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end

  # 判斷user是否有人追蹤
  def following?(user)
    self.followings.include?(user)    
  end

  # 使用者評論很多餐廳，餐廳被很多使用者評論
  # 如果User已經有了評論，就不允許刪除帳號(刪除時拋出Error)
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 使用者收藏很多餐廳的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # 使用者喜歡很多餐廳
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 使用者可以追蹤很多使用者followships
  has_many :followships, dependent: :destroy #可略class_name: "Followship", primary_key: "id", foreign_key: "user_id"
  has_many :followings, through: :followships #可略, source: :following
end
