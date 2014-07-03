class AddDefaultToPoints < ActiveRecord::Migration
  def up
    change_column :users, :points, :integer, default: 0
  end
end
