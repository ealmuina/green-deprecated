class Node < ApplicationRecord
  enum node_type: [:full, :pump, :valve]

  validates :chip_id, presence: true, uniqueness: true

  belongs_to :pump, class_name: 'Node', optional: true
  has_many :valves, class_name: 'Node', foreign_key: 'pump_id'

  has_many :records

  def current_moisture
    records.last&.moisture
  end

  def last_seen
    records.last&.created_at
  end
end
