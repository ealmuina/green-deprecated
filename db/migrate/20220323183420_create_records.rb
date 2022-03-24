class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.references :node, null: false, foreign_key: true
      t.date :date
      t.integer :moisture

      t.timestamps
    end
  end
end
