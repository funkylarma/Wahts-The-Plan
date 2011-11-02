function createMap(lat, lng, zoom) {
	var latlng = new google.maps.LatLng(lat, lng);
    var myOptions = {
    		zoom: zoom,
    		center: latlng,
    		mapTypeId: google.maps.MapTypeId.ROADMAP
    	};
    var map = new google.maps.Map(document.getElementById('map'), myOptions);
    return map;
}

function dropPin(lat, lng, map) {
	var latlng = new google.maps.LatLng(lat, lng);
	var marker = new google.maps.Marker({
		position: latlng,
		draggable: true,
		map: map,
		icon: '/img/info.png',
		animation: google.maps.Animation.DROP
	});
	return marker;
}

function geocodePosition(lat, lng) {
	var latlng = new google.maps.LatLng(lat, lng);
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({'latLng': latlng}, function(responses) {
		if (responses && responses.length > 0) {
			updateMarkerAddress(responses[0].formatted_address);
		} else {
			updateMarkerAddress('Cannot determine address at this location.');
		}
	});
}


function updateMarkerAddress(str) {
	$('#location').val(str);
}

function updateLatitude(lat) {
	$('#latitude').val(lat);
}

function updateLongitude(lng) {
	$('#longitude').val(lng);
}