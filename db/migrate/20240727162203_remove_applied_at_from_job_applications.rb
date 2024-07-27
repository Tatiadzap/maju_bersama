class RemoveAppliedAtFromJobApplications < ActiveRecord::Migration[7.1]
  def change
    remove_column :job_applications, :applied_at, :datetime
  end
end
