class RenameDisabilityNameToNameInDisabilities < ActiveRecord::Migration[7.1]
  def change
    rename_column :disabilities, :disability_name, :name
  end
end
