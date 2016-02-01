# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  commenter  :string
#  body       :text
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
