class AddStatusToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :status, :string, default: 'Draft'
    add_index :jobs, :status
  end
end
