class CommentsController < ApplicationController

  def create
    run Comment::Create do |op|
      redirect_to (article_path(op.article))
    end
  end

  def destroy
    run Comment::Destroy do |op|
      redirect_to article_path(op.article)
    end
  end

end
