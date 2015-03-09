Core = function(map) {
	
	var map;
	var geocoder;
	
	var initialize = function(map) {
		this.map = map;
		this.geocoder = geocoder = new google.maps.Geocoder();
	}
	
	this.onIndex = function() {

	}
	
	this.onInstant = function() {

	}
	
	initialize(map);
}