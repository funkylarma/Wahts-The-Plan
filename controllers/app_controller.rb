
get '/' do
  @pageTitle = "Home page"
  @subTitle = "listing local events"
  @events = Event.where(:updated_at.gte => 14.days.ago).sort(:updated_at.desc)
  erb :home
end

get '/login' do
  erb :'/promoter/login'
end
