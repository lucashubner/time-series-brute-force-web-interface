class RenameTsTblColumnName2 < ActiveRecord::Migration
  def change
            rename_column :ts_tbls, :ts_file_name, :ts
  end
end
