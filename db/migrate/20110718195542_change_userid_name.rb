class ChangeUseridName < ActiveRecord::Migration
  def self.up
    remove_column :projects, :userid
    add_column    :projects, :user_id, :integer
  end

  def self.down
    add_column    :projects, :userid, :integer
    remove_column :projects, :user_id
  end
end
