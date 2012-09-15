class AddPriorityToKpt < ActiveRecord::Migration
  def change
    add_column :kpts, :priority, :integer
    Kpt.all.each do|kpt|
      kpt.update_attributes(priority: kpt.id)
    end
  end
end
