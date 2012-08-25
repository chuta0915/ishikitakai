class InsertDefaultLevels < ActiveRecord::Migration
  def up
    Level.create do|s|
      s.id = 1
      s.priority = 1
      s.name = 'master'
    end
    Level.create do|s|
      s.id = 2
      s.priority = 2
      s.name = 'support'
    end
    Level.create do|s|
      s.id = 3
      s.priority = 3
      s.name = 'member'
    end
    Level.create do|s|
      s.id = 4
      s.priority = 4
      s.name = 'guest'
    end
  end

  def down
    Level.where(:id => [1, 2, 3, 4]).delete_all
  end
end
