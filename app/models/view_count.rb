class ViewCount < ApplicationRecord
  
  belongs_to :customer
  belongs_to :post_item
  
end
