require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  describe "GET index" do
    it "finds all the members in the database" do
      members = FactoryGirl.create_list(:member, 3)

      get :index
      expect(assigns(:members)).to eq(members)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET new" do
    it "assigns a member object for form" do
      get :new
      expect(assigns(:member)).to be_a_new(Member)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    subject { post :create, params: member_params }

    context "with valid parameters" do
      let(:member_params) {{ member: FactoryGirl.attributes_for(:member) }}

      it { is_expected.to redirect_to root_path }

      it "creates a new member" do
        expect{subject}.to change{Member.count}.by(1)
      end
    end

    context "without valid parameters" do
      let(:member_params) {{ member: FactoryGirl.attributes_for(:member, :no_email) }}

      it { is_expected.to render_template :new }

      it "does not create a new member" do
        expect{subject}.to change{Member.count}.by(0)
      end
    end

    context "with strong parameters" do
      let(:member_params) {{ member: FactoryGirl.attributes_for(:member, :include_balance) }}

      it "ignores the balance parameter" do
        subject
        expect(assigns(:member).balance).to eq(100.00)
      end
    end
  end

  describe "GET edit" do
    let(:member) { FactoryGirl.create(:member) }

    it "finds the correct member" do
      get :edit, params: {id: member.id}
      expect(assigns(:member)).to eq(member)
    end

    it "renders the edit template" do
      get :edit, params: {id: member.id}
      expect(response).to render_template :edit
    end
  end

  describe "POST update" do
    let(:member) { FactoryGirl.create(:member) }

    subject { post :update, params: member_params }

    context "with valid parameters" do
      let(:member_params) {{ member: {name: "Han Solo"} }}

      it { is_expected.to redirect_to root_path }

      it "updates the member" do
        subject
        expect(member.name).to eq("Han Solo")
      end
    end

    context "without valid parameters" do
      let(:member_params) {{ member: {email: nil} }}

      it { is_expected.to render_template :new }
    end
  end
end
