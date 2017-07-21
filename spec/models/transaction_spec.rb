require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction) { FactoryGirl.build(:transaction) }
  let(:member) { transaction.member }

  describe "validations" do
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

    context "when member will be overdrawn" do
      before { transaction.amount = -300.00 }

      it { is_expected.to be_falsey }

      it "returns an error message on the transaction" do
        subject
        expect(transaction.errors[:member]).to include(I18n.t('activerecord.errors.messages.member_overdrawn'))
      end
    end
  end

  describe "#update_member_balance" do
    context "when the transaction is not valid" do
      before { transaction.amount = -200.00 }

      it "does not ask member to save its balance" do
        expect(member).to_not receive(:save!)
        transaction.save
      end
    end

    context "when the transaction is valid" do
      it "asks the member to save its balance" do
        expect(member).to receive(:save!)
        transaction.save
      end

      it "successfully updates the member balance" do
        expect(member.balance).to eq(100.00)
        transaction.save
        expect(member.balance).to eq(56.65)
      end
    end
  end
end
