class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :group_id, null: false
      t.string :name, null: false
      t.boolean :done
      t.integer :created_user_id
      t.integer :completed_user_id

      t.timestamps
    end
    add_index :tasks, :group_id, name: 'idx_group_id_on_tasks'
  end
end
