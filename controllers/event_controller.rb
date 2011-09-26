
get '/event/create' do
  erb :'/events/create'
end

post '/event/create' do
  event = Event.create(params[:event])
  if event.save
    redirect '/'
  else
    redirect '/event/create'
  end
end