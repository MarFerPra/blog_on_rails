class Comment::Create < Trailblazer::Operation
  attr_accessor :article

  def process(params)
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(Comment.comment_params(params))
  end
end
