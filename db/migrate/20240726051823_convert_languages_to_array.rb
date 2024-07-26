class ConvertLanguagesToArray < ActiveRecord::Migration[7.1]
  def up
    # Step 1: Convert existing string data to PostgreSQL array format
    execute <<-SQL
      UPDATE candidates
      SET languages = string_to_array(languages, ', ')
      WHERE languages IS NOT NULL;
    SQL

    # Step 2: Change column type to text array
    change_column :candidates, :languages, :text, array: true, default: [], using: 'languages::text[]'
  end

  def down
    # Convert array back to comma-separated string
    execute <<-SQL
      UPDATE candidates
      SET languages = array_to_string(languages, ', ')
      WHERE languages IS NOT NULL;
    SQL

    # Revert the column type to text
    change_column :candidates, :languages, :text
  end
end
