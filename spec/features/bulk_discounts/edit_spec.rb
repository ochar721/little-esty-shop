require 'rails_helper'

RSpec.describe "Bulk Discount Edit Discount" do
  before(:each) do
    @merchant = create(:merchant)

    @discount1 = @merchant.bulk_discounts.create(name: "Halloween", percent: 20, quantity_threshold: 40)
    @discount2 = @merchant.bulk_discounts.create(name: "Mother's Day", percent: 30, quantity_threshold: 70)
    visit "/merchant/#{@merchant.id}/bulk_discounts/#{@discount1.id}"
  end

  it "Theres a link to edit the discount" do
    expect(page).to have_link("Edit Discount")
    click_link("Edit Discount")

    expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts/#{@discount1.id}/edit")

    fill_in 'Name', with: "Ice SCREAM"
    fill_in 'Percent', with: 21
    fill_in 'Quantity threshold', with:7
    click_button 'Update Bulk discount'

    expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts/#{@discount1.id}")
    expect(page).to have_content("Ice SCREAM")
    expect(page).to_not have_content("Halloween")
  end
end
