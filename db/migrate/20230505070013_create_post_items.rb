class CreatePostItems < ActiveRecord::Migration[6.1]
  def change
    create_table :post_items do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.integer :price, null: false
      t.text :explanation, null: false
      t.text :thoughts, null: false
      t.text :recommend_point, null: false
      t.timestamps
    end
  end
end
