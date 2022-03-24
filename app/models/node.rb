class Node < ApplicationRecord
  enum type: [:full, :pump, :valve]
end
