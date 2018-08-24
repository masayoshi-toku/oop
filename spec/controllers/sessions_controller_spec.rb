require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include SessionTestHelper
  render_views

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    subject { post :create, params: params }

    let(:user) { create(:user) }

    context "ログインしていた場合" do
      let(:params) { {} }
      before { log_in(user) }

      it { is_expected.to redirect_to users_path }
    end

    context "正しい値が送られてきたとき" do
      let(:params) { { session: { email: user.email, password: user.password } } }

      it { is_expected.to redirect_to users_path }
    end

    context "不正な値が送られてきたとき" do
      let(:params) { { session: { email: "invalid@mail.com", password: "invalid password" } } }

      it { is_expected.to render_template :new }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy }

    it { expect(is_logged_in?).to be false }
    it { expect(response).to redirect_to root_path }
  end
end
