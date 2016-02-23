class Article::Create < Trailblazer::Operation
  attr_accessor :article

  contract do
    property :title, validates: { presence: true,
                               length: {minimum: 5}
                              }
  end

  # OPERATION CODE GOES HERE
  def process(p)
    params = Article.article_params(p)
    @article = Article.new(params)
    validate(params,@article) do |f|
      f.save
    end
  end

end

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

class Article::Destroy < Trailblazer::Operation
  def process(params)
    @article = Article.find(params[:id])
    @article.destroy
  end
end
