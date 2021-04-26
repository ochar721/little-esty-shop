require 'rails_helper'

RSpec.describe "Bulk Discount Delete Discount" do
  before(:each) do
    @merchant = create(:merchant)

    @discount1 = @merchant.bulk_discounts.create(name: "Halloween", percent: 20, quantity_threshold: 40)
    @discount2 = @merchant.bulk_discounts.create(name: "Mother's Day", percent: 30, quantity_threshold: 70)
    visit "/merchant/#{@merchant.id}/bulk_discounts"
  end

  it "shows a link to delete " do
    within("#bulk_discounts") do
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_link("Delete #{@discount1.name}")

      click_link("Delete #{@discount1.name}")

      expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts")
      expect(page).to_not have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
    end
  end
end
