class AddUserIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :user_id, :int
  end
end
