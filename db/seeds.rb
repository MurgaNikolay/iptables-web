# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# token: iTMW5W6629i6D61wPSfUE65oZUcViyO8
# user: nikolay.m@randrmusic.com
user = User.find_by(access_token: Settings.api.token)
if user && user.email != Settings.api.user
  user.access_token = nil
  user.access_key = nil
  user.save
  user = nil
end

user = User.find_by(email: Settings.api.user)
unless user
  user = User.create({
      name: 'System user',
      email: Settings.api.user,
      internal: true
    })
end
user.access_token = Settings.api.token
user.access_key = Settings.api.key
user.save
