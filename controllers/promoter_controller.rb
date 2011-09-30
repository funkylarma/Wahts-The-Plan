
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

post '/promoter/login' do
  if promoter = Promoter.authenticate(params[:email], params[:password])
    session[:promoter] = promoter.id
    flash[:confirm] = "Login successful."
    redirect '/'
  else
    flash[:error] = "Could not log you in."
    redirect '/login'
  end
end
