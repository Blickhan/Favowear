class AddStylepointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :stylepoints, :integer, default: 0
  end
end
