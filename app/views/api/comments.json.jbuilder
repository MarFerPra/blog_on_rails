json.comments do

    json.array!(@comments) do |comment|
    json.extract! comment, :commenter, :body, :created_at
  end
end
