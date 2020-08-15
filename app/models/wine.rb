class Wine < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, ImagesUploader
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :area, presence: true, length: { maximum: 50 }
  validates :taste, presence: true, length: { maximum: 50 }
  validates :grape, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
end
