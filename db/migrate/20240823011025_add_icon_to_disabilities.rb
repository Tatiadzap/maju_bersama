class AddIconToDisabilities < ActiveRecord::Migration[7.1]
  def change
    add_column :disabilities, :icon, :string
  end
end
