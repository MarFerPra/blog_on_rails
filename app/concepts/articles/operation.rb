class Article::Create < Trailblazer::Operation

  contract do
    property :title, validates: { presence: true,
                               length: {minimum: 5}}
  end

    # OPERATION CODE GOES HERE
  def process(params)
    @article = Article.new(article_params(params))
    validate(article_params(params),@article) do |f|
      f.save
    end
  end
end

private
  def article_params(params)
    params.require(:article).permit(:title,:text,:author)
  end
