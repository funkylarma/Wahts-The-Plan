
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
  location = geocode(params[:postcode])
  latlng = Array[location.lng.to_f, location.lat.to_f]
  @events = Event.all  
  @locations = Hash.new

  @events.each do |event|    
                                                                           #latitude         #longtitude
     distanceInMiles = ((getDistance(location.lat.to_f,location.lng.to_f,event.location[1],event.location[0])) / 1000 ) * 0.621371192
     if distanceInMiles.to_f <= params[:radius].to_f     
                          #latitude         #longtitude
       latlngArr = Array[event.location[1], event.location[0]]
       @locations[event.id.to_s] = latlngArr
     end
  end
  
  
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