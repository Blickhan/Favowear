class AddUsersCountToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :users_count, :integer, default: 0
    add_index :categories, :users_count
  end
end
