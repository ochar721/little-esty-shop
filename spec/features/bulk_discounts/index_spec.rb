require 'rails_helper'

RSpec.describe "Bulk Discount Index Page" do
  before(:each) do
    @merchant = create(:merchant)

    @discount1 = @merchant.bulk_discounts.create(name: "Halloween", percent: 20, quantity_threshold: 40)
    @discount2 = @merchant.bulk_discounts.create(name: "Mother's Day", percent: 30, quantity_threshold: 70)

    visit "/merchant/#{@merchant.id}/bulk_discounts"
  end

  it "lists all discounts, their percents and threshold quantity" do
    expect(page).to have_content("Discounts for #{@merchant.name}")

    within("#bulk_discounts") do
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.percent)
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount2.percent)
      expect(page).to have_content(@discount2.quantity_threshold)

      expect(page).to have_link("Discount #{@discount1.name}")
    end
  end

  it "shows a header for upcoming  holidays" do
    expect(page).to have_content("Upcoming Holidays")
  end

  it "has a link to create a new discount" do
    expect(page).to have_link("Create Discount")
    click_link("Create Discount")
    expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts/new")
  end

  it "has a link to delete a discount next to the discount" do
    expect(page).to have_link("Delete #{@discount1.name}")
  end
end
