json.articles do
    json.array!(@articles) do |article|
    json.extract! article, :title, :text, :author
  end
end

json.success 'true'
json.total_articles @articles.count
