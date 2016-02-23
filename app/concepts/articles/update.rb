class Article::Update < Trailblazer::Operation
  attr_accessor :article

  contract do
    property :title, validates: { presence: true,
                               length: {minimum: 5}}
  end

  def process(params)
    @article = Article.find(params[:id])
    checked_params = Article.article_params(params)

    validate(checked_params, @article) do |f|
      @article.update(checked_params)
    end
  end
end
