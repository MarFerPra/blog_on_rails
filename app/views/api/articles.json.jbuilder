json.articles do
    json.array!(@articles) do |article|
    json.extract! article, :id, :title, :text, :author
  end
end
