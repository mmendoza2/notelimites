

json.users    @users do |user|
  json.userID                  user.id
  json.userUID                 user.uid
  json.name                    user.name
  json.slug                    user.slug
  json.email                   user.email
  json.url                     user_url(user, format: :json)


end

