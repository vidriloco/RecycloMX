$(document).ready(function() {
	
	if($.isDefined('#map')) {
		mapOptions = {
			center: new google.maps.LatLng(parseFloat(defaultLat), parseFloat(defaultLon)),
			zoom: defaultZoom,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			streetViewControl: true,
			mapTypeControl: false,
			navigationControl: false,
			navigationControlOptions: {
				position: google.maps.ControlPosition.TOP_RIGHT
			},
			zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL }
		};
		
		// The DOM id element where the coordinates will be written and read
		var coordinatesDOM = "#user_location";
		if($.isDefined('#offers') && $.isDefined('#offer-location-select')) {
			coordinatesDOM = "#offer_location";
		}
		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: coordinatesDOM.concat('_coordinates'),
			addressDom: coordinatesDOM.concat('_address'),
			isEditable: !$('#map').hasClass('non-editable'),
			skipWritingAddressToDomAtStart: $('#map').hasClass('initial-location-set')
		});
		
		if($('#map').hasClass('non-editable') || $('#map').hasClass('initial-location-set'))
			map.setCoordinatesFromDom(coordinatesDOM.concat('_coordinates'), locationZoom);
		else
			map.setCoordinatesFromDom(coordinatesDOM.concat('_coordinates'), 11);
		
	}
});