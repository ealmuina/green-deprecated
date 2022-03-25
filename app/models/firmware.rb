class Firmware < ApplicationRecord
  enum node_type: [:full, :pump, :valve]
  has_one_attached :file
end
