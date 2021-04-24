class CreatBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.decimal :percent
      t.integer :quantity_threshold
      t.integer :status
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
