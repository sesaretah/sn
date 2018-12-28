json.extract! post, :id, :stream_id, :uuid, :title, :content, :created_at, :updated_at
json.url post_url(post, format: :json)
