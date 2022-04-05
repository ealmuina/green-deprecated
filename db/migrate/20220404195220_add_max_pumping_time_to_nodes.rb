class AddMaxPumpingTimeToNodes < ActiveRecord::Migration[7.0]
  def change
    add_column :nodes, :max_pumping_time, :integer, default: 30
  end
end
