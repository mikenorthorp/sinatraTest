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


