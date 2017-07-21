require "rails_helper"

RSpec.describe "members/index.html.erb", type: :view do
  let(:members) { Member.all }

  before do
    FactoryGirl.create(:member)
    FactoryGirl.create(:member, name: "Mara Jade", balance: 25.00)
    FactoryGirl.create(:member, name: "Mon Mothma", balance: 75.00)
    assign(:members, Member.all)
    render
  end

  it "displays an ordered list of the members" do
    expect(rendered).to have_css("ol li", count: 3)
  end

  it "displays the name of each member" do
    members.each do |member|
      expect(rendered).to have_content(member.name)
    end
  end

  it "displays the balance of each member" do
    members.each do |member|
      expect(rendered).to have_content(member.balance)
    end
  end
end
