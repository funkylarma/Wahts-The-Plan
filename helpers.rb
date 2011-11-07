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
  
  def deg2rad(deg) 
    return (deg.to_f * Math::PI / 180)
  end

  def rad2deg(rad) 
    return (rad.to_f / Math::PI * 180)
  end
  
  def miles2Degrees(miles)
    earthsRadius = 6378 #km
    km = miles.to_f * 1.609344
    return ( km.to_f * earthsRadius.to_f )
  end

  def getDistance(lat1,lon1,lat2,lon2) 
      theta = lon1 - lon2
      dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta))
      rounded = (rad2deg(Math.acos(dist))* 60 * 1.1515 * 1.609344 * 1000).round(0)
      return (rounded).abs    
  end
  
  def removeEvent(id)
    event = Event.find(id)
    event.destroy
  end
  #Promoter Helper methods
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
  
  def promoter_name
    if session[:promoter]
      Promoter.find(session[:promoter]).name
    end
  end
  
end