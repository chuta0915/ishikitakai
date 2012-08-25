class AddNameImageDefaultProviderIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => '', :null => false
    add_column :users, :image, :string, :default => '', :null => false
    add_column :users, :default_provider_id, :integer, :default => 1, :null => false
  end
end
