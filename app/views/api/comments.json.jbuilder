json.comments do
    json.array!(@comments) do |comment|
    json.extract! comment, :commenter, :body
  end
end

json.success 'true'
json.total_articles @comments.count
