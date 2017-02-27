class User < ActiveRecord::Base
  #セーブする前にメールアドレスを小文字に変換する
  before_save {self.email = self.email.downcase}

  #名前の入力のルール
  validates :name, presence: true, length: {maximum: 50}
  
  #メールアドレスの入力ルール
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
              format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  
  #パスワードの暗号化をする
  has_secure_password
end
