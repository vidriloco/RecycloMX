var formLocateMe;
var mapLocateMe;

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
		if($.isDefined('#offer-location-select') || $.isDefined('#offer-details-show')) {
			coordinatesDOM = "#offer_location";
		}
		
		map = new ViewComponents.Map(new google.maps.Map(document.getElementById("map"), mapOptions), {
			coordinatesDom: coordinatesDOM.concat('_coordinates'),
			isEditable: !$('#map').hasClass('non-editable'),
			skipWritingAddressToDomAtStart: $('#map').hasClass('initial-location-set')
		});
		
		if($('#map').hasClass('non-editable') || $('#map').hasClass('initial-location-set')) {
			map.setCoordinatesFromDom(coordinatesDOM.concat('_coordinates'), locationZoom);      
		}
		else
			map.setCoordinatesFromDom(coordinatesDOM.concat('_coordinates'), 11);
		
    formLocateMe = function() {
      $('#locating-you').fadeIn('slow');
      $('#locate-me').hide();
      
      map.getCurrentPosition(function(location) {
        map.simulatePinPoint(location.coords.latitude, location.coords.longitude, 18);
        $('#locating-you').hide();
        $('#locate-me').fadeIn('slow');
      }, function() {
        alert('No fué posible obtener tu ubicación. Lo sentimos :(');
        $('#locating-you').hide();
        $('#locate-me').fadeIn('slow');
      })
    }
    
    mapLocateMe = function() {
      map.getCurrentPosition(function(location) {
        map.simulatePinPoint(location.coords.latitude, location.coords.longitude, 16);
      }, function() {
        alert('No fué posible obtener tu ubicación. Lo sentimos :(');
      })
    }
	}
});