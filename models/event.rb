class Event
  include MongoMapper::Document
  
  key :title, String, :required => true
  key :description, String, :required => true
  key :slug, String
  key :promoterId, String
  key :location, Array
  timestamps!
  
  ensure_index [[:location, '2d']]
  
end