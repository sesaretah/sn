json.extract! question, :id, :content, :stream_id, :uuid, :user_id, :created_at, :updated_at
json.url question_url(question, format: :json)
