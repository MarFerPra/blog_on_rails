json.comments do
    json.array!(@comments) do |comment|
    json.extract! comment, :commenter, :body
  end
end
