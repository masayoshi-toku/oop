require 'rails_helper'

RSpec.describe ArticleSearchQuery, type: :model do
  describe "#keyword" do
    let(:query) { ArticleSearchQuery.new(attributes) }

    context "検索パラメータがある場合" do
      let(:attributes) { { keyword: "test%" } }
      it { expect(query.keyword).to eq "%test\\%%" }
    end

    context "検索パラメータがない場合" do
      let(:attributes) { { keyword: nil } }
      it { expect(query.keyword).to be_nil }
    end
  end

  describe "#articles" do
    context "検索パラメータがない場合" do
      let!(:articles) { create_list(:article, 2) }
      let(:query) { ArticleSearchQuery.new }

      it { expect(query.articles).to eq articles }
    end

    context "keywordの指定がある場合" do
      let!(:article) { create(:article, title: "match") }
      let(:query) { ArticleSearchQuery.new(keyword: "match") }

      before do
        create(:article, title: "title")
      end

      it { expect(query.articles).to eq [article] }
    end

    context "toの指定がある場合" do
      let!(:article) { create(:article, title: "match") }
      let(:query) { ArticleSearchQuery.new(to: Time.zone.tomorrow.to_s) }

      before do
        travel_to 2.days.since do
          create(:article, title: "no match")
        end
      end

      it { expect(query.articles).to eq [article] }
    end

    context "fromの指定がある場合" do
      let!(:article) { create(:article, title: "match") }
      let(:query) { ArticleSearchQuery.new(from: Time.current.to_s) }

      before do
        travel_to 1.day.ago do
          create(:article, title: "no match")
        end
      end

      it { expect(query.articles).to eq [article] }
    end

    context "fromとtoの指定がある場合" do
      let!(:article) { create(:article, title: "match") }
      let(:query) { ArticleSearchQuery.new(from: Time.current.to_s, to: Time.zone.tomorrow.to_s) }

      before do
        travel_to 1.day.ago do
          create(:article, title: "no match")
        end
      end

      it { expect(query.articles).to eq [article] }
    end
  end
end
