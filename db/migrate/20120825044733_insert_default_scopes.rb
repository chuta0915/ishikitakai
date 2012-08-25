class InsertDefaultScopes < ActiveRecord::Migration
  def up
    Scope.create do|s|
      s.id = 1
      s.priority = 1
      s.name = 'public'
    end
    Scope.create do|s|
      s.id = 2
      s.priority = 2
      s.name = 'friends'
    end
    Scope.create do|s|
      s.id = 3
      s.priority = 3
      s.name = 'friends_friends'
    end
    Scope.create do|s|
      s.id = 4
      s.priority = 4
      s.name = 'closed'
    end
    Scope.create do|s|
      s.id = 5
      s.priority = 5
      s.name = 'private'
    end
  end

  def down
    Scope.where(:id => [1, 2, 3, 4, 5]).delete_all
  end
end
