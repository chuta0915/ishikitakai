class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name, :null => false
      t.integer :priority, :null => false
      t.timestamps
    end
    add_index :levels, :priority, :name => :idx_priority_on_levels
  end
end
