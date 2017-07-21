require "rails_helper"

RSpec.describe "transactions/new.html.erb", type: :view do
  before do
    assign(:transaction, Transaction.new)
    render
  end

  describe "transaction form" do
    it "displays a member email input" do
      expect(rendered).to have_field("member[email]")
    end

    it "displays a date input field" do
      expect(rendered).to have_field("transaction[date]")
    end

    it "displays a description input field" do
      expect(rendered).to have_field("transaction[description]")
    end

    it "displays an amount input field" do
      expect(rendered).to have_field("transaction[amount]")
    end
  end
end
