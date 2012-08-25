class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :name, :null => false
      t.integer :priority, :null => false
      t.timestamps
    end
    add_index :scopes, :priority, :name => :idx_priority_on_scopes
  end
end
