class Micropost < ActiveRecord::Base
  #複数の投稿は特定の1人のユーザーのものである
  belongs_to :user
  
  #ユーザーIDの入力規則
  validates :user_id, presence: true
  
  #投稿内容の入力規則
  validates :content, presence: true, length: {maximum: 140}
end
