class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|

      t.timestamps
    end
  end
end
