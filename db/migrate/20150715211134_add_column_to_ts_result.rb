class AddColumnToTsResult < ActiveRecord::Migration
  def change
    add_column :ts_results, :algorithm, :string
  end
end
