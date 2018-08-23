require "rails_helper"

RSpec.describe ArticleMailer, type: :mailer do
  describe "new_article" do
    let(:article) { create(:article) }
    let(:mail) { ArticleMailer.new_article(article) }

    it "renders the headers" do
      expect(mail.subject).to eq("New article")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(article.title)
    end
  end

end
