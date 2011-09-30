#helper methods

helpers do
  
  #Any includes
  include Rack::Utils
  
  #Helper alias
  alias_method :h, :escape_html
  
  #
  def return_url
    url = request.referer
    if url.nil?
      '/'
    elsif url.include? '/login'
      '/'
    else
      url
    end
  end
  
  #Event Helper Methods
  def geocode(address)
    Geokit::Geocoders::GoogleGeocoder.geocode(address)
  end
  
  def reverse_geocode(lat, lon)
    Geokit::Geocoders::GoogleGeocoder.reverse_geocode([lat, lon]).full_address
  end
  
  #User Helper methods
  def login_required
    if session[:promoter]
      return true
    else
      redirect '/login'
    end
  end
  
  def current_user
    if session[:promoter]
      Promoter.find(session[:promoter])
    else
      redirect '/login'
    end
  end
  
  def logged_in?
    if session[:promoter]
      return true
    else
      return false
    end
  end
  
end