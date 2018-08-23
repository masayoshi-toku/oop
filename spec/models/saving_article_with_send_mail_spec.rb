require 'rails_helper'

RSpec.describe SavingArticleWithSendMail, type: :model do
  describe "#save" do
    let(:article) { instance_double(Article, save: result) }

    context "保存に成功した場合" do
      let(:result) { true }
      let(:article) { create(:article) }
      let(:decorator) { SavingArticleWithSendMail.new(article) }
      let(:message_delivery) { instance_double(ActionMailer::MessageDelivery, deliver_now: true) }

      it do
        expect(ArticleMailer).to receive(:new_article).with(article) { message_delivery }
        expect(decorator.save).to be_truthy
      end
    end

    context "保存に失敗した場合" do
      let(:result) { false }
      let(:decorator) { SavingArticleWithSendMail.new(article) }

      it do
        expect(ArticleMailer).not_to receive(:new_article)
        expect(decorator.save).to be_falsey
      end
    end
  end
end
