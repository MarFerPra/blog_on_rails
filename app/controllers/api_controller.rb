class ApiController < ActionController::Base

  def articles
    @articles = Article.all
    render 'articles.json.jbuilder'
  end

  def comments
    @article = Article.find(params[:id])
    @comments = @article.comments.all
    render 'comments.json.jbuilder'
  end

end
