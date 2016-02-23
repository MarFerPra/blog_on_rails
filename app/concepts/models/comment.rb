class Comment < ActiveRecord::Base
  belongs_to :article
  
private
    def self.comment_params(params)
      params.require(:comment).permit(:commenter, :body)
    end
end
