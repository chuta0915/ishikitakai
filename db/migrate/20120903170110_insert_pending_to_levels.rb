class InsertPendingToLevels < ActiveRecord::Migration
  def up
    Level.create do|s|
      s.id = 5
      s.priority = 5
      s.name = 'pending'
    end
  end

  def down
    Level.where(:id => [5]).delete_all
  end
end
