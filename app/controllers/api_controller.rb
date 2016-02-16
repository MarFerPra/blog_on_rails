class ApiController < ActionController::Base

  def articles
    @articles = Article.all
    render 'articles.json.jbuilder'
  end

  def comments
    @comments = Comments.all
    render 'comments.json.jbuilder'
  end

end
