require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid" do
    subject { user }
    let(:user) { build(:user, params) }

    context "nameがnil場合" do
      let(:params) { { name: nil } }
      it { is_expected.to be_invalid }
    end

    context "nameが重複する場合" do
      let(:old_user) { create(:user) }
      let(:params) { { name: old_user.name } }
      it { is_expected.to be_invalid }
    end

    context "nameが正しい場合" do
      let(:params) { { name: "valid name" } }
      it { is_expected.to be_valid }
    end

    context "emailのnil場合" do
      let(:params) { { email: nil } }
      it { is_expected.to be_invalid }
    end

    context "emailが重複する場合" do
      let(:old_user) { create(:user) }
      let(:params) { { email: old_user.email } }
      it { is_expected.to be_invalid }
    end

    context "emailの形式が不正な場合" do
      let(:params) { { email: "invalid.email.com" } }
      it { is_expected.to be_invalid }
    end

    context "emailが正しい場合" do
      let(:params) { { email: "valid@email.com" } }
      it { is_expected.to be_valid }
    end
  end
end
