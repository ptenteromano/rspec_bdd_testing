class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render 'articles/new'
    end
  end

  def show
    # @article = Article.find(params[:id])
    @comment = @article.comments.build
    @comments = @article.comments
  end

  # edit action submits to update action
  def edit
    # @article = Article.find(params[:id])
    unless @article.user == current_user
      flash[:alert] = 'You can only edit or delete your own article'
      redirect_to root_path
    end
  end

  def update
    unless @article.user == current_user
      flash[:alert] = 'You can only edit or delete your own article.'
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to @article
      else
        flash[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end

  def destroy
    unless @article.user == current_user
      flash[:danger] = 'You can only edit or delete your own article'
    else
      if @article.destroy
      flash[:success] = "Article was successfully deleted"
      redirect_to articles_path
      end
    end
  end

  protected
    def resource_not_found
      message = "The article cannot be found"
      flash[:alert] = message
      redirect_to root_path
    end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def set_article
      @article = Article.find(params[:id])
    end

end
