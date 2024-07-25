class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :employer, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :location
      t.text :requirements

      t.timestamps
    end
  end
end
