class Group < ApplicationRecord
  has_one_attached :image

  has_many :group_users, dependent: :destroy
  has_many :customers, through: :group_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :name,presence:true
  validates :introduction,presence:true,length:{maximum:100}
  
  # グループ作成者情報管理
  def is_owned_by?(customer)
    owner_id == customer.id
  end
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
  
  # 検索情報の取得
  def self.search(group_keyword)
    where(["name like? OR introduction like?", "%#{group_keyword}%", "%#{group_keyword}%"])
  end
end
