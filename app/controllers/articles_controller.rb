class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all


    cate = params[:cate]

    if !cate.nil?
      @articles = Article.where(:category_id => cate)
    else 
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params.merge(user_id: current_user.id))

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!
    redirect_to '/', :notice => "L'article a bien été supprimé !"
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :category_id, :image, :youtube_id)
  end
end
