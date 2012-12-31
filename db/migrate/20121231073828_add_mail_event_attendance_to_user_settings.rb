class AddMailEventAttendanceToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :mail_event_attendance, :boolean, null: false, default: true
  end
end
