class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :job_title
      t.string :company_name
      t.date :start_date
      t.date :end_date
      t.text :description

      t.timestamps
    end
  end
end
