class CreateDisabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :disabilities do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description, null: false

      t.timestamps
    end
  end
end
