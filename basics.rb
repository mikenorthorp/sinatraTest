require 'rubygems'
require 'sinatra'

# Basics
get '/' do
	"Hello, World!"
end

get '/about' do
	"A little about me."
end

# Accessing params in url
get '/hello/:name' do
	"Hello there, #{params[:name].upcase}."
end

get '/hello/:name/:city' do
	"Hey there #{params[:name]} from #{params[:city]}!"
end

# multiple params with splat
get '/more/*' do
	params[:splat]
end

# View files and Post

get '/form' do
	erb :form # Loads erb file from /views/ and displays
end

# What to do on form post
post '/form' do
	"You said '#{params[:message]}'"
end

# Encrypting messages
get '/secret' do
	erb :secret
end

post '/secret' do
	params[:secret].reverse
end

# Decrypt the message
get '/decrypt/:secret' do
	params[:secret].reverse
end

# 404 Pages
not_found do
	halt 404, "Page not found!"
end



