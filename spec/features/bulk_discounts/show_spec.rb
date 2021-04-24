require 'rails_helper'

RSpec.describe "Bulk Discount Show Page" do
  before(:each) do
    @merchant = create(:merchant)

    @discount1 = @merchant.bulk_discounts.create(percent: 20, quantity_threshold: 40)
    @discount2 = @merchant.bulk_discounts.create(percent: 30, quantity_threshold: 70)

    visit "/merchant/#{@merchant.id}/bulk_discounts/#{@discount1.id}"
  end

  it "list an individual discount " do
    expect(page).to have_content("Discount Information")
      expect(page).to have_content(@discount1.percent)
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to_not have_content(@discount2.percent)
      expect(page).to_not have_content(@discount2.quantity_threshold)
  end
end
