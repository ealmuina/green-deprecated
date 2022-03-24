class Node < ApplicationRecord
  enum node_type: [:full, :pump, :valve]

  belongs_to :pump, class_name: 'Node', optional: true
  has_many :valves, class_name: 'Node', foreign_key: 'pump_id'
end
