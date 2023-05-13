class PostItem < ApplicationRecord

  has_one_attached :image

  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :comment_count, -> {order(comment: :desc)}
  
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
  
  # 検索情報の取得
  def self.search(keyword)
    where(["name like? OR price like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
