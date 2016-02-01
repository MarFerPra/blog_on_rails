# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author     :string
#

class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

# Trailblazin'
  def create
    run Article::Create do |op|
      return redirect_to (op.article)
    end
    render 'new'
  end

  def update
    run Article::Update do |op|
      return redirect_to (op.article)
    end
    render 'edit'
  end

  def destroy
    run Article::Destroy
    redirect_to articles_path
  end


end
