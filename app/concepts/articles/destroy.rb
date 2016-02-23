class Article::Destroy < Trailblazer::Operation
  def process(params)
    @article = Article.find(params[:id])
    @article.destroy
  end
end
