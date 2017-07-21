require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "validations" do
    let(:member) { FactoryGirl.build(:member) }

    subject { member.valid? }

    it { is_expected.to be_truthy }

    context "when there is no name" do
      let(:member) { FactoryGirl.build(:member, :no_name) }

      it { is_expected.to be_falsey }

      it "returns an error for the name field" do
        subject
        expect(member.errors[:name]).to include(I18n.t('activerecord.errors.messages.blank'))
      end
    end

    context "when there is a name" do
      it { is_expected.to be_truthy }
    end

    context "when there is no email" do
      let(:member) { FactoryGirl.build(:member, :no_email) }

      it { is_expected.to be_falsey }

      it "returns an error for the email field" do
        subject
        expect(member.errors[:email]).to include(I18n.t('activerecord.errors.messages.blank'))
      end
    end

    context "when there is an email" do
      it { is_expected.to be_truthy }
    end

    context "when there is already a member with the same email" do
      let!(:other_member) { FactoryGirl.create(:member, email: "leia@alderaan.gov") }

      before do
        member.email = "leia@alderaan.gov"
      end

      it { is_expected.to be_falsey }

      it "returns an error message about uniqueness" do
        subject
        expect(member.errors[:email]).to include(I18n.t('activerecord.errors.messages.taken'))
      end
    end

    context "when the balance will be less than -150.00" do
      before { member.balance = -160.00 }

      it { is_expected.to be_falsey }

      it "returns an error message on balance" do
        subject
        expect(member.errors[:balance]).to include(I18n.t('activerecord.errors.messages.greater_than_or_equal_to', count: -150.0))
      end
    end
  end

  describe "#update_balance" do
    let(:member) { FactoryGirl.create(:member) }

    subject { member.balance }

    it { is_expected.to eq(100.00) }

    context "when money is added" do
      before { member.update_balance(35.50) }
      it { is_expected.to eq(135.50) }
    end

    context "when money is subtracted" do
      before { member.update_balance(-45.00) }
      it { is_expected.to eq(55.00) }
    end
  end
end
