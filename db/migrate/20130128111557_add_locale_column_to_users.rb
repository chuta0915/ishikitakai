class AddLocaleColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :locale, :string
    User.update_all(locale: 'ja')
  end
  
  def down
    remove_column :users, :locale
  end
end
