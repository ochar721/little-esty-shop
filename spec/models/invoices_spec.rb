require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }
  end

  describe "Instance Method" do
    it "shows discounted revenue" do

    @merchant = create(:merchant)

    @item_1 = create(:item, merchant: @merchant, status: 0)
    @item_2 = create(:item, merchant: @merchant, status: 0)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)

    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_3.id)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 2, status: 1)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 5, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 50, status: 1)

    @halloween = @merchant.bulk_discounts.create(name: "Halloween", percent: 20, quantity_threshold: 3)
    @mothersday = @merchant.bulk_discounts.create(name: "Mother's Day", percent: 30, quantity_threshold: 15)


    expect(@invoice_1.total_discounted_revenue).to eq(5)
    expect(@invoice_2.total_discounted_revenue).to eq(60)
    expect(@invoice_3.total_discounted_revenue).to eq(0)å
    end
  end
end
