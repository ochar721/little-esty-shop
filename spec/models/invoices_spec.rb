require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }
  end

  describe 'instance methods' do
    before(:each) do
      @merchant = Merchant.create!(name: 'Ice Cream Parlour')
      @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
      @item_2 = @merchant.items.create!(name: 'Ice Cream Cones', description: 'holds the ice cream', unit_price: 10)
      @item_3 = @merchant.items.create!(name: 'Sprinkles', description: 'makes ice cream pretty', unit_price: 3)
      @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
      @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 13, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 10, status: 0)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 3, status: 0)
      @discount_1 = @merchant.bulk_discounts.create!(percent_discount: 0.2, quantity_threshold: 3)
    end

    describe '#total_revenue' do
      it "gets sum of revenue for all invoice items on the invoice" do
        invoice17 = Invoice.find(17)

        expect(invoice17.total_revenue).to eq(0.2474251e7)
      end
    end

    describe '#discounted_rev' do
      it "calculates quantitiy, unit price, and total discounted revenue on an invoice" do
        expect(@invoice_1.discounted_rev.first.quantity).to eq(3)
        expect(@invoice_1.discounted_rev.first.unit_price).to eq(3)
        expect(@invoice_1.discounted_rev.first.discounted_revenue).to eq(0.18e1)
      end
    end

    describe '#discounted_revenue' do
      it "test total revenue for an invoice after discounts have been applied" do
        expect(@invoice_1.invoice_items.count).to eq(3)
        expect(@invoice_1.invoice_items.total_revenue).to eq(32)
        expect(@invoice_1.discounted_revenue).to eq(0.302e2)
        expect(@invoice_1.invoice_items.total_revenue - @invoice_1.discounted_revenue).to eq(@invoice_1.discounted_rev.uniq.sum(&:discounted_revenue))
        expect(@invoice_1.invoice_items.total_revenue - @invoice_1.discounted_rev.uniq.sum(&:discounted_revenue).to_f).to eq(30.2)
        #not sure how to not hard-code line 54
      end
    end
  end
end
