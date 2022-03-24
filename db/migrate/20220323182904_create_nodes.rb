class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.string :chip_id
      t.integer :type
      t.integer :min_moisture
      t.integer :max_moisture
      t.references :pump, index: true
      t.boolean :open?

      t.timestamps
    end
  end
end
