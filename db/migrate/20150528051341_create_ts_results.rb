class CreateTsResults < ActiveRecord::Migration
  def change
    create_table :ts_results do |t|
      t.references :ts_tbl, index: true, foreign_key: true
      t.integer :motif_size
      t.float :limear
      t.string :normalize

      t.timestamps null: false
    end
  end
end
