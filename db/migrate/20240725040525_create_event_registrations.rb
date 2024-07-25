class CreateEventRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :event_registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.datetime :registered_at

      t.timestamps
    end
  end
end
