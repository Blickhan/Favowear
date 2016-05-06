class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :categories, :default, :is_default
  end
end
