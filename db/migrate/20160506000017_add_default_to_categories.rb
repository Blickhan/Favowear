class AddDefaultToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :default, :boolean, default: false
    add_index :categories, :default
  end
end
