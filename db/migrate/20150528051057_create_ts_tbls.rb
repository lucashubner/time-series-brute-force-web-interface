class CreateTsTbls < ActiveRecord::Migration
  def change
    create_table :ts_tbls do |t|
      t.references :user, index: true, foreign_key: true
      t.string :ts_file_path

      t.timestamps null: false
    end
  end
end
