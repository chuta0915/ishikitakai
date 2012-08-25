class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :group_id, :null => false
      t.integer :user_id, :null => false
      t.integer :level_id, :null => false

      t.timestamps
    end
    add_index :memberships, [:group_id], :name => :idx_group_id_on_memberships
    add_index :memberships, [:user_id, :group_id, :level_id], :name => :idx_user_id_group_id_level_id_on_memberships, :unique => true
  end
end
