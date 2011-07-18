class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string   :file
      t.integer  :project_id
      t.datetime :event_time

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
