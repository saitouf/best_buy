class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :introduction, unique: true
      
      t.timestamps
    end
  end
end
