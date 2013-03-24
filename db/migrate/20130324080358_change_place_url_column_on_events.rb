class ChangePlaceUrlColumnOnEvents < ActiveRecord::Migration
  def up
    change_column :events, :place_url, :text
  end

  def down
    change_column :events, :place_url, :string
  end
end
