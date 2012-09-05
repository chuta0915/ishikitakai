class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :type
      t.string :trigger_type
      t.integer :trigger_id
      t.string :name
      t.text :content
      t.boolean :read, :null => false, :default => false
      t.datetime :read_at

      t.timestamps
    end
    add_index :notifications, [:user_id, :read], :name => :idx_user_id_read_on_notifications
  end
end
