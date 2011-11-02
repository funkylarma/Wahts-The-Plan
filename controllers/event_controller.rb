
get '/event' do
  @title = "Find events"
  @pageTitle = "Find events"
  @events = Event.all
  erb :'/events/index'
end

get '/event/create' do
  login_required
  @pageTitle = promoter_name
  @subTitle = "Create new event"
  erb :'/events/create'
end

post '/event/create' do
  login_required
  @event = Event.create(params[:event])
  @event.promoterId = current_user.id
  location = geocode(params[:address])
  @event.location = Array[location.lng.to_f, location.lat.to_f]
  if @event.save
    redirect '/'
  else
    redirect '/event/create'
  end
end

get '/event/:id' do
  @event = Event.find(params[:id])
  @promoter = Promoter.find(@event.promoterId)
  @pageTitle = @event.title
  @subTitle = "@ #{@event.venue}"
  erb :'/events/detail'
end