class AddMailGroupEventToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :mail_group_event, :boolean, null: false, default: true
  end
end
