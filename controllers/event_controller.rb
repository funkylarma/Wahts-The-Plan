
get '/event' do
  @events = Event.all
  erb :'/events/index'
end

get '/event/create' do
  #login_required
  erb :'/events/create'
end

post '/event/create' do
  #login_required
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
  @pageTitle = @promoter.name
  @subTitle = @event.title
  erb :'/events/detail'
end