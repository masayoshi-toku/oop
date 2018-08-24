require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionTestHelper
  render_views

  describe "GET #index" do
    let(:user) { create(:user) }
    before { log_in(user) }

    it "returns http success" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    subject { post :create, params: params }

    context "登録に成功した場合" do
      let(:params) { { user: { name: "test name", email: "test@test.co.jp", password: "password" } } }
      it { is_expected.to redirect_to users_path }
    end

    context "登録に失敗した場合" do
      let(:params) { { user: { name: nil, email: nil, password: nil } } }
      it { is_expected.to render_template :new }
    end
  end
end
