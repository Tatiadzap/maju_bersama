class CreateDisabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :disabilities do |t|
      t.string :disability_name
      t.text :description

      t.timestamps
    end
  end
end
