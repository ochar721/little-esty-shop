require 'rails_helper'

RSpec.describe "Bulk Discount New Page" do
  before(:each) do
    @merchant = create(:merchant)
    visit "/merchant/#{@merchant.id}/bulk_discounts/new"
  end

  it "I fill in the form with valid data then redirected to the bulk index page and see my new discount" do

      fill_in "Name", with: "Fathers Day"
      fill_in "Percent", with: 15
      fill_in "Quantity threshold", with: 40
      click_button "Submit"
      expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts")

      expect(page).to have_content("Fathers Day")
      expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts")
      expect(page).to have_content("Fathers Day")
    end

  it "I dont fill in the entire form with valid data I then see a message asking me to fill out the form" do

    fill_in "Name", with: "Fathers Day"
    fill_in "Percent", with: ""
    fill_in "Quantity threshold", with: 40
    click_button "Submit"
    expect(current_path).to eq("/merchant/#{@merchant.id}/bulk_discounts/new")

      expect(page).to have_content("Please fill in all fields")
  end
end
