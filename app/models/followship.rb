class Followship < ApplicationRecord
  belongs_to :user #可省略, class_name: "User", primary_key: "id", foreign_key: "user_id"
  belongs_to :following, class_name: "User" #可省略, primary_key: "id", foregin_key: "following_id"
end
