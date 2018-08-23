class ArticleMailer < ApplicationMailer
  def new_article(article)
    @article = article
    mail to: "to@example.org"
  end
end
