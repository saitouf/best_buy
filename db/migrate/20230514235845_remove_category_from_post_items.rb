class RemoveCategoryFromPostItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_items, :category, :string
  end
end
