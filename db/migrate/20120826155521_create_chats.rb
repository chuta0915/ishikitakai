class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :group_id
      t.integer :user_id, :null => false
      t.text :content, :null => false

      t.timestamps
    end
    add_index :chats, [:group_id], :name => :idx_group_id_on_chats
  end
end
