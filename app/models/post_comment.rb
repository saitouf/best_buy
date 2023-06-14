class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post_item
  belongs_to :parent, class_name: 'PostComment', optional: true
  has_many   :replies, class_name: 'PostComment', foreign_key: :parent_id, dependent: :destroy
end
