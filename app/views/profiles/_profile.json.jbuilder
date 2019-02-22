json.extract! profile, :id, :name, :sex, :bio, :uuid, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
