
get '/' do
  @events = Event.all
  erb :home
end