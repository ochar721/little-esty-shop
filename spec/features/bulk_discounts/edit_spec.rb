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
  end
end

# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
