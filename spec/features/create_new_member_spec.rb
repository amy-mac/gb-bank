require "rails_helper"

RSpec.feature "create member page", type: :feature do
  scenario "creating a new member in the UI" do
    visit('/members/new')
    fill_in('Name', with: 'Jadzia')
    fill_in('Email', with: 'jadzia@ds9.com')
    click_button("Create Member")

    expect(page).to have_content("Member was successfully saved")
    expect(page).to have_content("Jadzia, jadzia@ds9.com")
  end
end
