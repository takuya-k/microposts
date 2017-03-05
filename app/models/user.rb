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
end
