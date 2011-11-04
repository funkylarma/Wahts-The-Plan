
get '/' do
  @title = "Whats the plan?"
  @pageTitle = "Not sure what to do?"
  @subTitle = "find something just for you"
  @events = Event.where(:updated_at.gte => 14.days.ago).sort(:updated_at.desc)
  erb :home
end

get '/login' do
  @title = "Log in"
  @pageTitle = "Log into your account"
  erb :'/promoter/login'
end

get '/logout' do
  session[:return_url] = nil
  session[:promoter] = nil
  flash[:confirm] = "Logged out"
  redirect '/'
end

get '/subscribe' do  
   @title = "Subscibe"
  @pageTitle = "Subscribe"
  erb :subscribe
end