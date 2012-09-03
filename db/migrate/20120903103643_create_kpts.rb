class CreateKpts < ActiveRecord::Migration
  def change
    create_table :kpts do |t|
      t.integer :group_id, null: false
      t.integer :user_id
      t.string :name
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end
  end
end
