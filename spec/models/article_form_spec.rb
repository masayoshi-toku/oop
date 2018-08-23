require 'rails_helper'

RSpec.describe ArticleForm, type: :model do
  describe "#category1_label" do
    let(:article) { Article.new }
    let(:article_form) { ArticleForm.new(article) }

    it { expect(article_form.category1_label).to eq "株式" }
  end

  describe "#category2_label" do
    let(:article) { Article.new }
    let(:article_form) { ArticleForm.new(article) }

    it { expect(article_form.category2_label).to eq "投資信託" }
  end

  describe "#category3_label" do
    let(:article) { Article.new }
    let(:article_form) { ArticleForm.new(article) }

    it { expect(article_form.category3_label).to eq "FX" }
  end

  describe "#category_ids" do
    subject { article_form.category_ids }

    let(:article) { Article.new }
    let(:article_form) { ArticleForm.new(article, params) }

    context "categoryの指定がない場合" do
      let(:params) { {} }
      it { is_expected.to eq [] }
    end

    context "category1の指定がある場合" do
      let(:params) { { category1: "1" } }
      it { is_expected.to eq [1] }
    end

    context "category1〜3の指定がある場合" do
      let(:params) { { category1: "1", category2: "1", category3: "1" } }
      it { is_expected.to eq [1, 2, 3] }
    end
  end

  describe "#params" do
    let(:article) { Article.new }
    let(:article_form) { ArticleForm.new(article, title: title) }
    let(:title) { "title" }
    let(:result) { { title: title, body: nil, category_ids: [] } }

    it { expect(article_form.params).to eq result }
  end

  describe "#save" do
    # 引数でArticleが渡されているのは、フォームオブジェクトの中でArticleを生成することが不便なのでDIしている。
    let(:article) { Article.new }
    let(:article_form) { ArticleForm.new(article, params) }

    context "保存に成功した場合" do
      let(:params) { { title: "title", body: "body body", category1: "1" } }

      it { expect(article_form.save).to be_truthy }
      it { expect{ article_form.save }.to change{ Article.count }.by(1) }
      it { expect{ article_form.save }.to change{ ArticlesCategory.count }.by(1) }
    end

    context "保存に失敗した場合" do
      let(:params) { { body: "body", category1: "1" } }

      it { expect(article_form.save).to be_falsy }
      it { expect{ article_form.save }.to change{ Article.count }.by(0) }
      it { expect{ article_form.save }.to change{ ArticlesCategory.count }.by(0) }
    end
  end
end
