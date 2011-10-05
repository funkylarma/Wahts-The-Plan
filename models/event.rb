class Event
  include MongoMapper::Document
  
  key :title, String, :required => true
  key :description, String, :required => true
  key :venue, String
  key :date, DateTime
  key :url, String
  key :promoterId, String
  key :location, Array
  key :category, String
  timestamps!
  
  ensure_index [[:location, '2d']]
  
end