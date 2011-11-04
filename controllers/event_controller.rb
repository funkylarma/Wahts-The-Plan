get '/event/myevents' do
  login_required
  @title = "My Events"
  @pageTitle = "My Events"
  @events = Event.where(:promoterId.to_s => current_user.id.to_s)  
  
  erb :'/events/myevents'
end

get '/event' do
  @title = "Find events"
  @pageTitle = "Find events"
  @events = Event.all
  erb :'/events/index'
end

get '/event/results/*' do
  @search = {
    :postcode => params[:postcode],
    :type => params[:type],
    :afterDate => params[:afterDate],
    :beforeDate => params[:beforeDate],
    :radius => params[:radius]
  }
  @location = geocode(params[:postcode])
  latlng = Array[@location.lng.to_f, @location.lat.to_f]
  
  #@locations = Event.all  
  #@locations = Event.where(:location => {'$near' => [latlng[1], latlng[0]], '$maxDistance' => 0.01 })
  
  @locations = Event.where(:location => { '$within' => { '$center' => [latlng, deg2rad(params[:radius])]}})
    
  erb :'events/results' 
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
  location = geocode(params[:building] + params[:address] )
  if location == nil
    location = geocode(params[:address])
  end
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