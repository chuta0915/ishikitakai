class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id, :null => false
      t.integer :group_id
      t.integer :scope_id, :null => false
      t.string :name, :null => false
      t.text :content
      t.text :summary, :null => false
      t.string :place_url
      t.string :place_name, :null => false
      t.string :place_address
      t.string :place_map_url
      t.integer :capacity_min, :null => false
      t.integer :capacity_max, :null => false
      t.datetime :begin_at
      t.datetime :end_at
      t.datetime :receive_begin_at
      t.datetime :receive_end_at
      t.integer :event_payment_kind_id, :null => false
      t.integer :fee

      t.timestamps
    end
    add_index :events, :user_id, :name => :idx_user_id_on_events
    add_index :events, :group_id, :name => :idx_group_id_on_events
  end
end
