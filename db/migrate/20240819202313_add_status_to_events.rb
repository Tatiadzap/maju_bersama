class AddStatusToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :status, :string, default: 'Draft'
    add_index :events, :status
  end
end
