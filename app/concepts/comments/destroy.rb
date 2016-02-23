class Comment::Destroy < Trailblazer::Operation
  attr_accessor :article

  def process(params)
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  end
end
