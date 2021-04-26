class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :invoice_items

  validates_presence_of :status, :customer_id

  enum status: [:"in progress", :completed, :cancelled]

  scope :incomplete_invoices, -> { includes(:invoice_items).where.not(status: 2).distinct.order(:created_at)}

  def total_discount
    invoice_items
    .joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .select('bulk_discounts.*, invoice_items.*, (invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percent /100) AS discounted_rev')
    .order('bulk_discounts.percent desc')
  end

  def total_discounted_revenue
    discount = total_discount.uniq.sum(&:discounted_rev)
    (invoice_items.total_revenue - discount).to_f.round(2)
  end
end
