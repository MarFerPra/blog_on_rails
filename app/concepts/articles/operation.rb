class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  class Create < Trailblazer::Operation
    attr_accessor :article

    contract do
      property :title, validates: { presence: true,
                                 length: {minimum: 5}}
    end

      # OPERATION CODE GOES HERE
    def process(p)
      params = article_params(p)
      @article = Article.new(params)
      validate(params,@article) do |f|
        f.save
      end
    end

    private
    def article_params(params)
      params.require(:article).permit(:title,:text,:author)
    end

  end
end
