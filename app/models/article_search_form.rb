class ArticleSearchForm
  include ActiveModel::Model
  attr_accessor :keyword
  attr_writer :from, :to
  validates :keyword, length: { maximum: 10 }, allow_nil: true
  validate :ensure_to_date_format, :ensure_from_date_format

  def to
    @to&.to_date
  rescue ArgumentError
    nil
  end

  def from
    @from&.to_date
  rescue ArgumentError
    nil
  end

  def articles
    query.articles
  end

  private

    def ensure_to_date_format
      ensure_date_format(:to_date, @to)
    end

    def ensure_from_date_format
      ensure_date_format(:from_date, @from)
    end

    def ensure_date_format(column, value)
      Date.parse(value) unless value.blank?
    rescue ArgumentError
      errors.add column, "日時の書式にあやまりがあります"
    end

    def query
      ArticleSearchQuery.new(keyword: keyword, from: from, to: to)
    end
end
