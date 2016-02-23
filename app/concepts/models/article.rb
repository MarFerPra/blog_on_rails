class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  private
  def self.article_params(params)
    params.require(:article).permit(:title,:text,:author)
  end
end
