class AddDefaultGroupToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :default_group, :boolean
  end
end
