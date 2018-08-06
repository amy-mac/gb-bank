require "rails_helper"

RSpec.describe "layouts/application.html.erb", type: :view do
  before do
    render
  end

  it "doesn't error with no page_title assigned" do
    expect(rendered).to have_css("h1", text: "Gb Bank")
  end

  it "displays the navigation links in the header" do
    expect(rendered).to have_css("nav li", count: 3)
  end

  it "displays the members index link" do
    expect(rendered).to have_link("Members")
  end

  it "displays the create member link" do
    expect(rendered).to have_link("Create Member")
  end

  it "displays the create transaction link" do
    expect(rendered).to have_link("Create Transaction")
  end
end
