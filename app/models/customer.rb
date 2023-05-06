class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  
  has_many :post_items, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  # プロフィール画像有無確認
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'icon_nouser.jpg'
  end
end
