class User < ApplicationRecord
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
end
