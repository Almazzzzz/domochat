json.array!(@polls) do |poll|
  json.extract! poll, :id, :title, :body, :start, :finish, :status, :type, :user_id
  json.url poll_url(poll, format: :json)
end
