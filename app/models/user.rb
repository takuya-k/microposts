class User < ActiveRecord::Base
  #セーブする前にメールアドレスを小文字に変換する
  before_save {self.email = self.email.downcase}

  #名前の入力のルール
  validates :name, presence: true, length: {maximum: 50}
  
  #メールアドレスの入力ルール
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
              format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
              
  #プロフィールの入力ルール(未入力でもOK)
  validates :profile, presence: true, length: {maximum: 160}, if: "profile.present?"
  
  #地域の入力のルール(未入力でもOK)
  validates :area, presence: true, length: {maximum: 50}, if: "area.present?"
  
  #生年月日の入力(未入力でもOK)
  validates :birthday, presence: true, length: {minimum: 8, maximum: 8}, numericality: {only_integer: true}, if: "birthday.present?"
 
  #パスワードの暗号化をする
  has_secure_password
  
  #一人のユーザーにつき複数の投稿を保持できるようにする
  has_many :microposts
  
  #一人のユーザーがフォローしているrelationshipの集まり
  has_many :following_relationships, class_name: "Relationship",
              foreign_key: "follower_id", dependent: :destroy
              
  
  #一人のユーザーがフォローしている人の集まり
  has_many :following_users, through: :following_relationships, source: :followed
  
  #一人のユーザーをフォローしているrelationshipの集まり
  has_many :follower_relationships, class_name: "Relationship",
              foreign_key: "followed_id", dependent: :destroy
  
  #一人のユーザーをフォローしている人の集まり
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  #他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  #フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  #あるユーザーをフォローしているかどうか
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
