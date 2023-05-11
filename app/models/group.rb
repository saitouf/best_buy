class Group < ApplicationRecord
  has_one_attached :image

  has_many :group_users, dependent: :destroy
  has_many :customers, through: :group_users, dependent: :destroy, source: :user
  has_many :messages, dependent: :destroy
  
  # グループ作成者情報管理
  def is_owned_by?(customer)
    owner_id == customer.id
  end
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
