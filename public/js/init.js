

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


function panToPoint(map, point, zoom) {
	window.setTimeout(function(){
		map.panTo(point);
		if (zoom != undefined) {
			map.setZoom(zoom);
		}
	}, 400);
}

function updateMarkerAddress(str) {
	$('#postcode').val(str);
}

function updateLatitude(lat) {
	$('#latitude').val(lat);
}

function updateLongitude(lng) {
	$('#longitude').val(lng);
}