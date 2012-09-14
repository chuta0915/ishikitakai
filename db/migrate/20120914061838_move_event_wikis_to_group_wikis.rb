class MoveEventWikisToGroupWikis < ActiveRecord::Migration
  def up
    Wiki.all.each do|wiki|
      parent = wiki.parent
      next if parent.nil?
      if parent.class == Event && parent.group.present?
        wiki.parent_type = 'Group'
        wiki.parent_id = parent.group.id
        wiki.save!
      end
    end
  end

  def down
  end
end
