class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column    :users, :current_project_id, :integer
    add_column    :users, :hashed_secret, :string
  end

  def self.down
    remove_column :users, :current_project_id
    remove_column :users, :hashed_secret
  end
end
