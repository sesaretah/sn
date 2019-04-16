ThinkingSphinx::Index.define :stream, :primary_key => :integer_id,:with => :real_time do
  indexes title
  indexes details
end
