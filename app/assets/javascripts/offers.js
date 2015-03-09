Offer = function() {
  thisInstance = this;
  
  this.showLocation = function() {
    var id = this.params['id'];
		var modalID = '#location-'.concat(id).concat(' .modal');
		$(modalID).modal('show');
    $(modalID.concat(' .close')).on('click', thisInstance.resetURL);
  }
  
  this.resetURL = function() {
    window.location = '#/';
    thisInstance.hideAllOpenLocations();
  }
  
  this.hideAllOpenLocations = function() {
    $('.modal').modal('hide');
  }
  
}

$(document).ready(function() {
	if($.isDefined('#offers-list')) {
		var offer = new Offer();
		Path.map("#/").to(offer.hideAllOpenLocations);
		Path.map("#/locations/:id").to(offer.showLocation);
    
    Path.root('#/');
		Path.listen();
    
    // Load offer locations on to the map
		var offers = $('.offer-location');
		for(var i = 0 ; i < offers.length ; i++) {
			var offer = $(offers[i]);
			var marker = {lat: offer.attr('data-lat'), lon: offer.attr('data-lng'), locationID: offer.attr('id') };
			map.addCoordinatesAsMarkerToList(marker, function(opts) {
        var id = opts.locationID.split('-');
        window.location = '#/locations/'.concat(id[1]);
			});
		}
	}
  
  // Dismisses a group list element (kind of hack)
  $('.dismisser').on('click', function() {
    var id = $('.dismisser').attr('data-dismiss');
    $('.'.concat(id).concat('-dismiss')).remove();
  });
});