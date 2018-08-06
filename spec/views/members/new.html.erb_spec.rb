require "rails_helper"

RSpec.describe "members/new.html.erb", type: :view do
  before do
    assign(:member, Member.new)
    render
  end

  describe "member form" do
    it "displays a name input field" do
      expect(rendered).to have_field("member[name]")
    end

    it "displays an email input field" do
      expect(rendered).to have_field("member[email]")
    end
  end
end
