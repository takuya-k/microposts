class Micropost < ActiveRecord::Base
  #ユーザーIDの入力規則
  validates :user_id, presence: true
  
  #投稿内容の入力規則
  validates :content, presence: true, length: {maximum: 140}
  
  #複数の投稿は特定の1人のユーザーのものである
  belongs_to :user
  
  #
  has_many :favorites, foreign_key: "micropost_id", dependent: :destroy
  
  #
  has_many :favorites_userss, class_name: "User", through: :favorites,  source: :micropost
end
