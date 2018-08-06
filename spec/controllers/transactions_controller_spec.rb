require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe "GET new" do
    it "assigns a transaction object for form" do
      get :new
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let!(:member) { FactoryGirl.create(:member) }

    subject { post :create, params: transaction_params }

    context "with valid parameters" do
      let(:transaction_params) do
        {
          transaction: FactoryGirl.attributes_for(:transaction, :no_member),
          member: {
            email: member.email
          }
        }
      end

      it { is_expected.to redirect_to root_path }

      it "creates a new transaction" do
        expect{subject}.to change{Transaction.count}.by(1)
        expect(member.transactions).to include(assigns(:transaction))
      end
    end

    context "with incorrect member email" do
      let(:transaction_params) do
        {
          transaction: FactoryGirl.attributes_for(:transaction, :no_member),
          member: {
            email: "person@glassbreakers.co"
          }
        }
      end

      it { is_expected.to render_template(:new) }

      it "doesn't find a member in the database" do
        subject
        expect(assigns(:member)).to be_nil
      end

      it "doesn't create a transaction" do
        expect{subject}.to change{Member.count}.by(0)
      end
    end

    context "without valid parameters" do
      let(:transaction_params) do
        {
          transaction: FactoryGirl.attributes_for(:transaction, :no_member, description: nil),
          member: {
            email: member.email
          }
        }
      end

      it { is_expected.to render_template :new }

      it "does not create a new transaction" do
        expect{subject}.to change{Transaction.count}.by(0)
      end
    end

    context "with strong parameters" do
      let(:transaction_params) do
        {
          transaction: FactoryGirl.attributes_for(:transaction, :no_member, member_id: 1),
          member: {
            email: "person@glassbreakers.co"
          }
        }
      end

      it "ignores the member_id parameter" do
        subject
        expect(assigns(:transaction).member_id).to be_nil
      end
    end
  end
end
