class ArticleSearchQuery
  include ActiveModel::Model
  attr_writer :keyword
  attr_accessor :from, :to

  def articles
    scope = Article.all
    scope = scope.where(conditions.join(" AND "), values) if conditions.count.nonzero?
    scope
  end

  def keyword
    "%#{Article.sanitize_sql_like(@keyword)}%" if @keyword
  end

  private
    def conditions
      result = []
      result << "title like :keyword" if keyword
      result << "created_at >= :from" if from
      result << "created_at <= :to" if to
      result
    end

    def values
      { from: from&.to_time, to: to&.to_time, keyword: keyword }
    end
end
