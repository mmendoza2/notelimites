json.array!(@relationships) do |relation|
  json.extract! relation,
                :created_at,
                :updated_at,
                :id,
                :follower_id,
                :followed_id
end
