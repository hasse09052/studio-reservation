class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password

  before_save { self.email = self.email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    return BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークン用の文字列(Base64で長さ22)を返す
  def User.new_token
    return SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにハッシュ化したトークンをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # データベース上のトークンを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 渡されたトークンを暗号化したものと、データベース上のものと一致したらtrueを返す(データベースのトークンが無かったらfalseを返す)
  def authenticated?(remember_token)
    if self.remember_digest.nil?
      return false
    else
      return BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
    end
  end

end
