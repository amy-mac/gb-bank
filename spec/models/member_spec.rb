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
        expect(member.errors[:email]).to include(I18n.t('activerecord.errors.messages.unique'))
      end
    end
  end
end
