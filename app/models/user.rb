class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save { self.email.downcase! }
  
  mount_uploader :image, ImagesUploader
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :wines
  
  has_many :favorites
  has_many :favorited, through: :favorites, source: :wine
  
  def favorite(wine)
    self.favorites.find_or_create_by(wine_id: wine.id)
  end
  
  def unfavorite(wine)
    favorite = self.favorites.find_by(wine_id: wine.id)
    favorite.destroy if favorite
  end
  
  def favorite?(wine)
    self.favorited.include?(wine)
  end
  
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
