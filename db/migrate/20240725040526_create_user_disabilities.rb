class CreateCandidateDisabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :candidate_disabilities do |t|
      t.references :candidate, null: false, foreign_key: true, index: true
      t.references :disability, null: false, foreign_key: true, index: true
      t.text :details

      t.timestamps
    end
    add_index :candidate_disabilities, [:candidate_id, :disability_id], unique: true
  end
end
