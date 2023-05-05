class AddCustomerIdToPostItems < ActiveRecord::Migration[6.1]
  def change
    add_column :post_items, :customer_id, :integer
  end
end
