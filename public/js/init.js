function createMap(lat, lng, zoomLevel, mapDom) {
	var latlng = new google.maps.LatLng(lat, lng);
	var options = {
		zoom: zoomLevel,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	var map = new google.maps.Map(document.getElementById(mapDom), options);
	return map;
}

function dropPin(lat, lng, map) {
	var latlng = new google.maps.LatLng(lat, lng);
	var marker = new google.maps.Marker({
		position: latlng,
		draggable: false,
		map: map,
		animation: google.maps.Animation.DROP
	});
	return marker;
}