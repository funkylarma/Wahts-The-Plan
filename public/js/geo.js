function initiate_geolocation() {
	$('#address').val("Trying to locate you...");
	navigator.geolocation.getCurrentPosition(handle_location_query, handle_error);
}

function handle_error(error) {
	switch(error.code)
	{
		case error.PERMISSION_DENIED: $('#feedback').html('<p class="error">You did not share your geolocation data.<br />You need to allow your browser to use your location, or use the map below and click on your location</p></p>');
		break;
		
		case error.POSITION_UNAVAILABLE: $('#feedback').html('<p class="error">Could not detect current position.<br />Please use the map below and click on your location</p>');
		handle_location_query();	
		break;
		
		case error.TIMEOUT: $('#feedback').html('<p class="error">Retrieving position timed out.<br />Please use the map below and click on your location</p></p>');
		break;
		
		default: $('#feedback').html('<p class="error">Unknown error.<br />Please use the map below and click on your location</p></p>');
		break;
	}
}

function handle_location_query(position) {
	
	//Build some variables
	var latitude, longitude, zoom;
	
	//Check to see if we know the location
	if (position == null) {
		latitude = 51.5;
		longitude = 0.00;
		zoom = 5;
	} else {
		latitude = position.coords.latitude;
		longitude = position.coords.longitude;
		zoom = 14;
	}
	
	//Update the long and lat of the position
	updateLatitude(latitude);
	updateLongitude(longitude);
	
	//Geocode the position and populate the address
	geocodePosition(latitude, longitude);
		
}