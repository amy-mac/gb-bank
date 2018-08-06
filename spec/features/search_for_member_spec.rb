require "rails_helper"

RSpec.feature "members/index search for members", type: :feature, js: true do
  background do
    %w(Luke Leia Han Chewie).each do |name|
      FactoryGirl.create(:member, name: name)
    end
  end

  scenario "when searching for existing members" do
    visit '/members'
    expect(page).to have_css("ol li", count: 4)

    fill_in 'Search for member', with: 'l'
    expect(page).to have_css("ol li", count: 2)
    expect(page).to have_content("Leia")
    expect(page).to have_content("Luke")
  end

  scenario "when searching for a non-existent member" do
    visit '/members'

    fill_in 'Search for member', with: 'za'
    expect(page).to have_content("No results found")
    expect(page).to_not have_css("ol li")
  end
end

