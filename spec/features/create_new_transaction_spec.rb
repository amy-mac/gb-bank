require "rails_helper"

RSpec.feature "create transaction page", type: :feature do
  background do
    @member = FactoryGirl.create(:member)
  end

  scenario "creating a new transaction in the UI" do
    visit('/transactions/new')
    fill_in('Member email', with: @member.email)
    fill_in('Date of Transaction', with: Time.zone.yesterday)
    fill_in('Description', with: 'Dinner')
    fill_in('Amount', with: -45.00)
    click_button("Create Transaction")

    expect(page).to have_content("Transaction was successfully saved")
    expect(page).to have_content("#{@member.name}, #{@member.email}")
    expect(page).to have_content("Balance: $55.00")
  end
end
