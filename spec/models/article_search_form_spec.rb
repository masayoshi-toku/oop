require 'rails_helper'

RSpec.describe ArticleSearchForm, type: :model do
  describe "#valid?" do
    let(:form) { ArticleSearchForm.new(attributes) }

    context "keywordが10文字以内の場合" do
      let(:attributes) { { keyword: "a" * 10 } }
      it { expect(form).to be_valid }
    end

    context "keywordが10文字以上の場合" do
      let(:attributes) { { keyword: "a" * 11 } }
      it { expect(form).to be_invalid }
    end

    context "keywordがnilの場合" do
      let(:attributes) { { keyword: nil } }
      it { expect(form).to be_valid }
    end

    context "fromが日時に変換できる場合" do
      let(:attributes) { { from: "2018-08-22" } }
      it { expect(form).to be_valid }
    end

    context "fromが日時に変換できない場合" do
      let(:attributes) { { from: "can not parse" } }
      it { expect(form).to be_invalid }
    end

    context "fromがnilの場合" do
      let(:attributes) { { from: nil } }
      it { expect(form).to be_valid }
    end
  end

  describe "to" do
    let(:form) { ArticleSearchForm.new(attributes) }

    context "パラメーターがある場合" do
      let(:attributes) { { to: date } }
      let(:date) { "2018-08-22" }

      it { expect(form.to).to eq Date.parse(date) }
    end

    context "パラメーターがない場合" do
      let(:attributes) { {} }

      it { expect(form.to).to be_nil }
    end

    context "日時変換ができない場合" do
      let(:attributes) { { to: "can not parse" } }

      it { expect(form.to).to be_nil }
    end

    context "toが日時に変換できる場合" do
      let(:attributes) { { to: "2018-08-22" } }
      it { expect(form).to be_valid }
    end

    context "toが日時に変換できない場合" do
      let(:attributes) { { to: "can not parse" } }
      it { expect(form).to be_invalid }
    end

    context "toがnilの場合" do
      let(:attributes) { { to: nil } }
      it { expect(form).to be_valid }
    end
  end

  describe "from" do
    let(:form) { ArticleSearchForm.new(attributes) }

    context "パラメーターがある場合" do
      let(:attributes) { { from: date } }
      let(:date) { "2018-08-22" }

      it { expect(form.from).to eq Date.parse(date) }
    end

    context "パラメーターがない場合" do
      let(:attributes) { {} }

      it { expect(form.from).to be_nil }
    end

    context "日時変換ができない場合" do
      let(:attributes) { { from: "can not parse" } }

      it { expect(form.from).to be_nil }
    end
  end

  describe "#articles" do
    let(:query) { instance_double(ArticleSearchQuery, articles: nil) }
    let(:form) { ArticleSearchForm.new }

    before do
      allow(ArticleSearchQuery).to receive(:new) { query }
    end

    it do
      expect(query).to receive(:articles)
      expect(form.articles).to be_nil
    end
  end
end
