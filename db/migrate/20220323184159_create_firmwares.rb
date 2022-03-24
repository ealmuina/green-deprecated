class CreateFirmwares < ActiveRecord::Migration[7.0]
  def change
    create_table :firmwares do |t|
      t.integer :node_type
      t.integer :version

      t.timestamps
    end
  end
end
