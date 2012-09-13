class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id, null: false
      t.boolean :mail_attend_status, null: false, default: true

      t.timestamps
    end
    add_index :user_settings, :user_id, name: :idx_user_id_on_user_settings
  end
end
