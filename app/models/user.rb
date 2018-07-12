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
  # 使用者評論很多餐廳，餐廳被很多使用者評論
  # 如果User已經有了評論，就不允許刪除帳號(刪除時拋出Error)
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 使用者收藏很多餐廳的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant


end
