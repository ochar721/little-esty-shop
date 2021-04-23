class RemovePercentFromBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :bulk_discounts, :percent, :decimal
  end
end
