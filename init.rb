#Require gems
%w[sinatra json mongo_mapper rack-flash geokit].each { |gem| require gem }

#Setup the database connections
if ENV['MONGOLAB_URI']
  uri = URI.parse(ENV['MONGOLAB_URI'])
  MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
  db = uri.path.gsub(/^\//, '')
  MongoMapper.database = db
else
  MongoMapper.database = "whats_the_plan"
end

#Setup site requirements
use Rack::Session::Cookie, :secret => 'Stuck for nothing to do'
use Rack::Flash

#Require the models
%w[promoter event].each do |model|
  require File.join(File.dirname(__FILE__), "models", model)
end

#Require controllers
%w[app promoter event].each do |controller|
  require File.join(File.dirname(__FILE__), "controllers", controller + "_controller")
end