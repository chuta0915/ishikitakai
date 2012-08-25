class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, :null => false
      t.text :summary, :null => false
      t.text :content
      t.integer :scope_id, :null => false

      t.timestamps
    end
    add_index :groups, :name, :name => :idx_name_on_groups
  end
end
