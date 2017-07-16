require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    let(:transaction) { FactoryGirl.build(:transaction) }

    subject { transaction.valid? }

    it { is_expected.to be_truthy }

    context "when there is no description" do
      before { transaction.description = nil }

      it { is_expected.to be_falsey }

      it "returns an error message on the description" do
        subject
        expect(transaction.errors[:description]).to include(I18n.t('activerecord.errors.messages.blank'))
      end
    end

    context "when there is no amount" do
      before { transaction.amount = nil }

      it { is_expected.to be_falsey }

      it "returns an error message on the amount" do
        subject
        expect(transaction.errors[:amount]).to include(I18n.t('activerecord.errors.messages.blank'))
      end
    end

    context "when there is no date" do
      before { transaction.date = nil }

      it { is_expected.to be_falsey }

      it "returns an error message on the date" do
        subject
        expect(transaction.errors[:date]).to include(I18n.t('activerecord.errors.messages.blank'))
      end
    end

    context "when date is in the future" do
      before { transaction.date = Time.zone.tomorrow }

      it { is_expected.to be_falsey }

      it "returns an error message on the date" do
        subject
        expect(transaction.errors[:date]).to include(I18n.t('activerecord.errors.messages.no_date_in_future'))
      end
    end
  end
end
