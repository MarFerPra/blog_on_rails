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
