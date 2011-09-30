
get '/' do
  @pageTitle = "Home page"
  @subTitle = "listing local events"
  @events = Event.all
  erb :home
end

get '/login' do
  erb :'/promoter/login'
end
