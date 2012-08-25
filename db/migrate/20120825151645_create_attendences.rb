class CreateAttendences < ActiveRecord::Migration
  def change
    create_table :attendences do |t|
      t.integer :event_id, :null => false
      t.integer :user_id, :null => false
      t.integer :level_id, :null => false
      t.string :content

      t.timestamps
    end
    add_index :attendences, [:event_id], :name => :idx_event_id_on_attendences
    add_index :attendences, [:user_id, :event_id], :name => :idx_user_id_event_id_on_attendences, :unique => true
  end
end
