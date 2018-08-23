class ArticleForm
  include ActiveModel::Model

  attr_accessor :title, :body, :category1, :category2, :category3
  attr_reader :article

  delegate :persisted?, to: :article

  validates :title, presence: true, article_length: { attribute: :body, minimum: 10 }
  validates :body, presence: true

  def initialize(article, params = {})
    @article = article
    # superの先はActiveModel::Model
    super(params)
  end

  def category1_label
    categories[1]
  end

  def category2_label
    categories[2]
  end

  def category3_label
    categories[3]
  end

  def save
    return false unless valid?
    # attributes=()よりもpermitted?を調べるという意味でこっちがいいかも。
    article.assign_attributes(params)

    # モデルの方のエラーも表示させたい場合
    if article.invalid?
      article.errors.each do |key, value|
        errors.add key, value
      end

      return false
    end

    article.save
  end

  def params
    { title: title, body: body, category_ids: category_ids }
  end

  def category_ids
    ids = []
    ids << 1 if category1 == "1"
    ids << 2 if category2 == "1"
    ids << 3 if category3 == "1"
    ids
  end

  private

    def categories
      @_categories ||= Category.article_checkboxes
    end
end
