class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :parent_type
      t.integer :parent_id
      t.integer :user_id
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
