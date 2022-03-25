class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.string :chip_id, index: { unique: true, name: 'unique_chip_ids' }
      t.integer :node_type
      t.integer :min_moisture
      t.integer :max_moisture
      t.references :pump, class: 'Node', null: true
      t.boolean :open?, default: false

      t.timestamps
    end
  end
end
