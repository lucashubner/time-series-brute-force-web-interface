class RenameTsTblColumnName3 < ActiveRecord::Migration
  def change
      rename_column :ts_tbls, :ts, :ts_file_name
  end
end
