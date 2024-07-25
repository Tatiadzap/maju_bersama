class CreateEmployers < ActiveRecord::Migration[7.1]
  def change
    create_table :employers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.text :company_description
      t.string :website
      t.string :industry

      t.timestamps
    end
  end
end
