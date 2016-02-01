class Comment < ActiveRecord::Base
  belongs_to :article

  class Create < Trailblazer::Operation
    attr_accessor :article

    def process(params)
      @article = Article.find(params[:article_id])
      @comment = @article.comments.create(Comment.comment_params(params))
    end
  end

  class Destroy < Trailblazer::Operation
    attr_accessor :article

    def process(params)
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
    end
  end

private
    def self.comment_params(params)
      params.require(:comment).permit(:commenter, :body)
    end

end
