class UpdateScopePriority < ActiveRecord::Migration
  def up
    Scope.where(id:[2,3,4]).all.each do |scope|
      scope.priority = -1
      scope.save
    end
  end

  def down
    Scope.where(id:2).first.priority = 2
    Scope.where(id:3).first.priority = 3
    Scope.where(id:4).first.priority = 4
  end
end
