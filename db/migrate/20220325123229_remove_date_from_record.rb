class RemoveDateFromRecord < ActiveRecord::Migration[7.0]
  def change
    remove_column :records, :date
  end
end
