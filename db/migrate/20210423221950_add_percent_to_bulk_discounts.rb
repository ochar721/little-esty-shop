class AddPercentToBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_column :bulk_discounts, :percent, :integer
  end
end
