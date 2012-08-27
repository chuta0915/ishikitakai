class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :parent_type, :null => false
      t.integer :parent_id, :null => false
      t.integer :user_id
      t.string :name
      t.text :content, :null => false

      t.timestamps
    end
    add_index :wikis, [:parent_type, :parent_id], :name => :idx_parent_type_parent_id_on_wikis
  end
end
