# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Tweet.destroy_all

glenn = User.create!(name:"Glenn", email:'stoplecturing@me.com')
shawn = User.create!(name:"Shawn", email:'handlebar@mustache.com')
jimmy = User.create!(name:"Jimmy", email:'jimmycorazon@sprintervan.com')
blaise = User.create!(name:"Blaise", email:'uk-badboy@mrinternational.com')


1.upto(10) do |i|
  shawn.tweets.create!(body:"Tweet no. #{i}")
end

1.upto(10) do |i|
  glenn.tweets.create!(body:"Tweet no. #{i}")
end

1.upto(10) do |i|
  jimmy.tweets.create!(body:"Tweet no. #{i}")
end

1.upto(10) do |i|
  blaise.tweets.create!(body:"Tweet no. #{i}")
end