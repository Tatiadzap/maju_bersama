class RenameUserDisabilitiesToCandidateDisabilities < ActiveRecord::Migration[7.1]
  def change
    rename_table :candidate_disabilities, :candidate_disabilities
    rename_column :candidate_disabilities, :user_id, :candidate_id
  end
end
