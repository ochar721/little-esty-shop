require 'rails_helper'

RSpec.describe "Bulk Discount Show Page" do
  before(:each) do
    @merchant = create(:merchant)

    @halloween = @merchant.bulk_discounts.create(name: "Hallowen", percent: 20, quantity_threshold: 40)
    @christmas = @merchant.bulk_discounts.create(name: "Christmas", percent: 30, quantity_threshold: 70)

    visit "/merchant/#{@merchant.id}/bulk_discounts/#{@halloween.id}"
  end

  it "list an individual discount " do
    expect(page).to have_content("Discount Information")
      expect(page).to have_content(@halloween.percent)
      expect(page).to have_content(@halloween.quantity_threshold)
      expect(page).to_not have_content(@christmas.percent)
      expect(page).to_not have_content(@christmas.quantity_threshold)
  end
end
