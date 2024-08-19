class RemoveRegisteredAtFromEventRegistration < ActiveRecord::Migration[7.1]
  def change
    remove_column :event_registrations, :registered_at, :datetime
  end
end
