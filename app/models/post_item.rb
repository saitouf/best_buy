class PostItem < ApplicationRecord
  
  # 並び替え時whereで指定した順番で取得
  extend OrderAsSpecified

  has_one_attached :image

  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  # 投稿を、新しい・古い順に並び替えソート
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  validates :name, presence: true 
  validates :price, presence: true, numericality: true
  validates :tag_ids, presence: true
  validates :thoughts, presence: true
  validates :explanation, presence: true, length: {maximum:300}
  validates :recommend_point, presence: true, length: {maximum:300}
  
  
  
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
    where(["name like? OR price like? OR explanation like? OR thoughts like? OR recommend_point like?",
          "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
end
