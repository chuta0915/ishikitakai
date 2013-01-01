class ChangeDoneColumnDefaultOnTasks < ActiveRecord::Migration
  def up
    Task.where(done: nil).update_all(done: false)
    change_column :tasks, :done, :boolean, default: false
  end

  def down
    change_column :tasks, :done, :boolean
  end
end
