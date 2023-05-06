class PostItem < ApplicationRecord

  has_one_attached :image

  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # 投稿画像の有無を確認
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  # 自身のいいね有無を確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
