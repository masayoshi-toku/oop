class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    # @articles = Article.all
    @article_search_form = ArticleSearchForm.new(article_search_form_params)
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article_form = ArticleForm.new(Article.new)
  end

  # GET /articles/1/edit
  def edit
    @article_form = ArticleForm.new(@article, @article.form_params)
  end

  # POST /articles
  def create
    @article_form = ArticleForm.new(Article.new, article_form_params)
    decorator = SavingArticleWithSendMail.new(@article_form)

    if decorator.save
      redirect_to @article_form.article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    @article_form = ArticleForm.new(@article, article_form_params)

    if @article_form.save
      redirect_to @article_form.article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params[:article]&.permit(:title, :body)
    end

    def article_form_params
      params.require(:article_form).permit(:title, :body, :category1, :category2, :category3)
    end

    def article_search_form_params
      params[:article_search_form]&.permit(:keyword, :from, :to)
    end
end
