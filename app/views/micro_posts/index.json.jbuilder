json.array!(@micro_posts) do |micro_post|
  json.extract! micro_post, :id, :user_id, :text
  json.url micro_post_url(micro_post, format: :json)
end
