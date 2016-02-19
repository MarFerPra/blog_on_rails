class ApiController < ActionController::API

  def articles
    @articles = Article.all
    render 'articles.json.jbuilder'
  end

  def comments
    @article = Article.find(params[:id])
    @comments = @article.comments.all
    render 'comments.json.jbuilder'
  end

  def isLogged?
    
  end

end
