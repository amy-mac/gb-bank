require "rails_helper"

RSpec.feature "navigation links", type: :feature do
  scenario "navigating to each page" do
    visit('/members')
    expect(page).to have_css("h1", text: "Members")

    click_link("Create Member")
    expect(page).to have_css("h1", text: "Create New Member")

    click_link("Create Transaction")
    expect(page).to have_css("h1", text: "Create new transaction")
  end
end
