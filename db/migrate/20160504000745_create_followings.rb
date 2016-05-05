class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
    add_index :followings, :user_id
    add_index :followings, :category_id
    add_index :followings, [:user_id,:category_id], unique: true
  end
end
