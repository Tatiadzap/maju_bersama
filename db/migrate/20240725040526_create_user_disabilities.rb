class CreateUserDisabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :user_disabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :disability, null: false, foreign_key: true
      t.text :details

      t.timestamps
    end
  end
end
