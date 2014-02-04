class CreateJoinTableGroupUser < ActiveRecord::Migration
  def change
    create_join_table :groups, :users, :id => false do |t|
      t.integer [:group_id, :user_id]
      t.integer [:user_id, :group_id]
    end

    add_index :groups_users, :group_id
    add_index :groups_users, :user_id
  end
end
