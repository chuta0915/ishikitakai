class AddMailEventCommentToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :mail_event_comment, :boolean, null: false, default: true
  end
end
