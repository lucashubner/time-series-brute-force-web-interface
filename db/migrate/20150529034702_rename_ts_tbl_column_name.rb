class RenameTsTblColumnName < ActiveRecord::Migration
  def change
      rename_column :ts_tbls, :ts_file_path, :ts_file_name
  end
end
