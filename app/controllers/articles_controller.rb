class ArticlesController < ApplicationController

def index
  @articles = Article.all.order("created_at DESC")
end

def new
  @article = Article.new
end

def create(article_params)
  @article = Article.create(article_params)
  redirect_to action: :index
end

private
def article_params
  params.permit(:title, :text, :image)
end

end
