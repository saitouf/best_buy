class PostTagRelation < ApplicationRecord
  belongs_to :post_item
  belongs_to :tag
end
