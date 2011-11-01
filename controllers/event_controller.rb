
get '/event' do
  @title = "Find events"
  @pageTitle = "Find events"
  @events = Event.all
  erb :'/events/index'
end

get '/event/results/*' do
  
  @postcode = params[:postcode]
  location = geocode(params[:postcode])
  @latlng = Array[location.lng.to_f, location.lat.to_f]
  @radius = params[:radius]
  @type = params[:type]
  @afterDate = params[:afterDate]
  @beforeDate = params[:beforeDate]
  allEvents = Event.all  
  @locations = Hash.new
  
  allEvents.each do |event|
      distanceInMiles = ((getDistance(location.lat.to_f,location.lng.to_f,event.location[1],event.location[0])) / 1000 ) * 0.621371192
      @test = distanceInMiles
      if distanceInMiles.to_f <= params[:radius].to_f
       @locations[event.id] = event.title
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

def deg2rad(deg) 
  return (deg * Math::PI / 180)
end

def rad2deg(rad) 
  return (rad / Math::PI * 180)
end

def getDistance(lat1,lon1,lat2,lon2) 
    theta = lon1 - lon2
    dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta))
    rounded = (rad2deg(Math.acos(dist))* 60 * 1.1515 * 1.609344 * 1000).round(0)
    return (rounded).abs    
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
  @subTitle = "@ #{@promoter.name}"
  erb :'/events/detail'
end