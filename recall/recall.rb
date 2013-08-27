require 'rubygems'
require 'sinatra'
require 'data_mapper'

# Set up initial database with datamapper
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

# Creates a notes table
class Note
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

# Auto update table when new data removed or entered
DataMapper.finalize.auto_upgrade!

# Views
get '/' do
	@notes = Note.all :order => :id.desc
	@title = "All Notes"
	erb :home
end

post '/' do
	n = Note.new
	n.content = params[:content]
	n.created_at = Time.now
	n.updated_at = Time.now
	n.save
	redirect '/'
end

# Edit notes
get '/:id' do
	@note = Note.get params[:id]
	@title = "Edit note ##{params[:id]}"
	erb :edit
end

# Route for our put request
put '/:id' do
	n = Note.get params[:id]
	n.content = params[:content]
	n.complete = params[:complete] ? 1 : 0
	n.updated_at = Time.now
	n.save
	redirect '/'
end

get '/:id/delete' do
	@note = Note.get params[:id]
	@title = "Confirm deleition of note ##{params[:id]}"
	erb :delete
end

delete '/:id' do
	n = Note.get params[:id]
	n.destroy
	redirect '/'
end

get '/:id/complete' do
	n = Note.get params[:id]
	n.complete = n.complete ? 0 : 1 # flip it
	n.updated_at = Time.now
	n.save
	redirect '/'
end


