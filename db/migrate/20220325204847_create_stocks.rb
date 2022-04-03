class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references :bearer, foreign_key: true, null: false
      t.string :name, null: false, index: { unique: true }

      t.timestamps
      t.datetime :deleted_at, index: true
    end
  end
end
