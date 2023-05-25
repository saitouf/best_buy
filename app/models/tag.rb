class Tag < ApplicationRecord

  has_many :post_tag_relations, dependent: :destroy
  has_many :post_items, through: :post_tag_relations, dependent: :destroy
  
end
