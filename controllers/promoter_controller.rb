
get '/promoter' do
  @title = "Find event promoters"
  @pageTitle = "Find event promoters"
  @promoters = Promoter.all
  erb :'/promoter/index'
end

get '/promoter/register-step1' do  
  
  erb :'/promoter/register-step1'
end

get '/promoter/register-step2/:level' do  
  @level = params[:level]
  
  if @level == "gold"
    @price = 149
  else 
    if @level == "silver"
      @price = 99
    else 
      @price= 49
    end
  end
  erb :'/promoter/register-step2'
end

post '/promoter/register-step2' do  
  
  erb :'/promoter/register-step3'
end
get '/promoter/register-step3' do  
  level = params[:level]
  erb :'/promoter/register-step3'
end

post '/promoter/register-step3' do
  promoter = Promoter.create(params[:promoter])
  promoter.membershipLevel = params[:level]
  if promoter.save
    flash[:confirm] = "Account created"
    redirect '/event/myevents'
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

get '/promoter/profile' do
  login_required
  @title = "Your profile"
  @events = Event.where(:promoterId.to_s => current_user.id.to_s) 
  @pageTitle = promoter_name
  @subTitle = "Your profile"
  erb :'/promoter/profile'
end

get '/promoter/edit' do
  login_required
  @title = "Edit your profile"
  @pageTitle = promoter_name
  @subTitle = "Edit your profile"
  @promoter = Promoter.find(session[:promoter])
  erb :'/promoter/edit'
end

get '/promoter/:id' do
  @promoter = Promoter.find(params[:id])
  @title = @promoter.name
  @pageTitle = @promoter.name
  @events = Event.where(:promoterId.to_s => @promoter.id.to_s)
  erb :'/promoter/detail'
end
