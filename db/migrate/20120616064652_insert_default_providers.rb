class InsertDefaultProviders < ActiveRecord::Migration
  def up
    Provider.create do|p|
      p.id = 1
      p.name = 'facebook'
    end
    Provider.create do|p|
      p.id = 2
      p.name = 'twitter'
    end
    Provider.create do|p|
      p.id = 3
      p.name = 'github'
    end
  end

  def down
    Provider.where(:id => [1, 2, 3]).delete_all
  end
end
