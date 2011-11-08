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
    
  erb :'/events/results' 
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
  if params[:building] == nil
    location = geocode(params[:address])
  else
  location = geocode(params[:building] + params[:address] ) 
  end
  @event.location = Array[location.lng.to_f, location.lat.to_f] 
  if @event.save
    redirect '/'
  else
    redirect '/event/create'
  end
  
end

get '/event/delete/:id' do
  event = Event.find(params[:id])
  if event.promoterId.to_s == current_user.id.to_s
    event.destroy
  end
  
  redirect '/event/myevents'
end

get '/event/edit/:id' do
  @event = Event.find(params[:id])
  @promoter = Promoter.find(current_user.id) 
  if @event.promoterId.to_s == current_user.id.to_s
    erb :'/accessdenied'
  end
  @location = reverse_geocode(@event.location[1], @event.location[0])
  @pageTitle = "Editing " + @event.title
  @subTitle = "@ #{@event.venue}"
  erb :'/events/edit'
end

post '/event/edit/:id' do
  login_required
  @event = Event.find(params[:id]) 
  @event.title = params[:title]
  @event.description = params[:description]
  @event.date = params[:date]
  @event.url = params[:url]
  @event.venue = params[:venue]-
  @event.category = params[:category] 
  if params[:building] == nil
    @event.location = geocode(params[:address])
  else
  @event.location = geocode(params[:building] + params[:address] ) 
  end
  @event.location = Array[location.lng.to_f, location.lat.to_f]
  @event.save  
end

get '/upload' do
  erb :'/upload'  
end

post '/upload' do
  service = Service.buckets
  bucket = Bucket.find('WhatsThePlan')
  file = params[:filename]
  id = S3Object.store(file, open(file), 'whatstheplan')
end

get '/event/:id' do
  @event = Event.find(params[:id])
  @promoter = Promoter.find(@event.promoterId)
  @isOwner = false
  if logged_in?
    if @event.promoterId.to_s == current_user.id.to_s
      @isOwner = true
    end
  end  
  @pageTitle = @event.title
  @subTitle = "@ #{@event.venue}"
  erb :'/events/detail'
end



