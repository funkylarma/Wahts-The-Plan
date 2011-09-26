
get '/promoter' do
  @promoters = Promoter.all
  erb :'/promoter/index'
end

get '/promoter/create' do
  erb :'/promoter/create'
end

post '/promoter/create' do
  promoter = Promoter.create(params[:promoter])
  if promoter.save
    flash[:confirm] = "Account created"
    redirect '/'
  else
    flash[:error] = "Error!"
    redirect '/'
  end
end
