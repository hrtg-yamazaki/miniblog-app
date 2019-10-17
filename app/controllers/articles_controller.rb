class ArticlesController < ApplicationController

before_action :move_to_index, except: [:index, :show]

def index
  @articles = Article.all.order("created_at DESC")
end

def new
  @article = Article.new
end

def create
  @article = Article.create(article_params)
  redirect_to action: :index
end

def destroy
  article = Article.find(params[:id])
  if current_user.id == article.user_id
    article.destroy
    redirect_to action: :index
  end
end

def edit
  @article = Article.find(params[:id])
end

def update
  article = Article.find(params[:id])
  if current_user.id == article.user_id
    article.update(article_params)
    redirect_to action: :index
  end
end

def show
  @article = Article.find(params[:id])
end

private

def article_params
  params.require(:article).permit(:title, :text, :image).merge(user_id: current_user.id)
end

def move_to_index
  redirect_to action: :index unless user_signed_in?
end

end
