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