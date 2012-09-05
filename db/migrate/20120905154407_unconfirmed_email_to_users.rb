class UnconfirmedEmailToUsers < ActiveRecord::Migration
  def up
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirm_limit_at, :datetime
    add_column :users, :hash_to_confirm_email, :string
  end

  def down
    remove_column :users, :unconfirmed_email
    remove_column :users, :confirm_limit_at
    remove_column :users, :hash_to_confirm_email
  end
end
