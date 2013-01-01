class RenameIndexNameOnAttendance < ActiveRecord::Migration
  def up
    remove_index :attendances, :name => :idx_event_id_on_attendences
    remove_index :attendances, :name => :idx_user_id_event_id_on_attendences
    add_index :attendances, [:event_id], :name => :idx_event_id_on_attendances
    add_index :attendances, [:user_id, :event_id], :name => :idx_user_id_event_id_on_attendances, :unique => true
  end

  def down
    remove_index :attendances, :name => :idx_event_id_on_attendances
    remove_index :attendances, :name => :idx_user_id_event_id_on_attendances
    add_index :attendances, [:event_id], :name => :idx_event_id_on_attendences
    add_index :attendances, [:user_id, :event_id], :name => :idx_user_id_event_id_on_attendences, :unique => true
  end
end
