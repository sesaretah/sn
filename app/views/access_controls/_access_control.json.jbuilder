json.extract! access_control, :id, :uuid, :role_id, :ability_to_create_stream, :ability_to_create_discussion, :ability_to_comment, :ability_to_create_question, :ability_to_create_answer, :created_at, :updated_at
json.url access_control_url(access_control, format: :json)
