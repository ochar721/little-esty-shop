class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percent_discount, :quantity_threshold
end
