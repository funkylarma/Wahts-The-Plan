#Require gems
%w[sinatra json mongo_mapper rack-flash geokit aws/s3].each { |gem| require gem }

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

#Site constants
EMAIL_REGEXP = /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i
CATEGORIES = {:all => "Type (all)", :concert => "Concert", :festival => "Festival", :live_music => "Live Music", :night_club => "Night Club", :pub => "Pub" }
DISTANCE = {5 => "Within 5 miles", 10 => "Upto 10 miles", 20 => "Upto 20 miles", 40 => "Upto 40 miles"}

#Require helpers
require_relative 'helpers'

#Require libaries
%w[content_for].each do |lib|
  require File.join(File.dirname(__FILE__), "lib", lib)
end

#Require the models
%w[promoter event].each do |model|
  require File.join(File.dirname(__FILE__), "models", model)
end

#Require controllers
%w[app promoter event].each do |controller|
  require File.join(File.dirname(__FILE__), "controllers", controller + "_controller")
end

AWS::S3::Base.establish_connection!(
    :access_key_id     => 'AKIAJRAG6DS75CQOXWEQ',
    :secret_access_key => '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'
  )