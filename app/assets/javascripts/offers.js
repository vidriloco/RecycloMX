Offer = function() {
  thisInstance = this;
  
  this.showLocation = function() {
    var id = this.params['id'];
    loadLocation(id);
  }
  
  this.collectForOffer = function() {
    var id = this.params['id'];
    var offerId = this.params['offer_id'];
    loadLocation(id);
    
		var offerID = '#offer-'.concat(offerId).concat(' .modal-footer');
    $(offerID.concat(' .collect')).fadeIn(300);
    $(offerID.concat(' .actions')).hide();
  }
  
  this.resetURL = function() {
    window.location = '#/';
    thisInstance.hideAllOpenLocations();
  }
  
  this.hideAllOpenLocations = function() {
    $('.modal').modal('hide');
  }
  
  this.hideProposals = function() {
    $('.header-proposal').removeClass('active');
    $('.conversation').hide();
    $('.header-proposal').each(function() {
      $(this).attr('href', $(this).attr('data-url'));
    });
  }
  
  this.showProposal = function() {
    var id = this.params['id'];
    thisInstance.hideProposals();
		$('#proposal-'.concat(id).concat(' > .header-proposal')).addClass('active');
    $('#proposal-'.concat(id).concat(' .conversation')).fadeIn('slow');
    $('#proposal-'.concat(id).concat(' > .header-proposal')).attr('href', '#/');
  }
  
  var loadLocation = function(id) {
		var modalID = '#location-'.concat(id).concat(' .modal');
		$(modalID).modal('show');
    $(modalID.concat(' .close')).on('click', thisInstance.resetURL);
    
    $('.offer-for-picker .collect').hide();
    $('.offer-for-picker .actions').show();
  }
}

$(document).ready(function() {
	if($.isDefined('#offers-list')) {
		var offer = new Offer();
		Path.map("#/").to(offer.hideAllOpenLocations);
		Path.map("#/locations/:id").to(offer.showLocation);
		Path.map("#/locations/:id/collect/:offer_id").to(offer.collectForOffer);
        
    Path.root('#/');
		Path.listen();
    
    // Drop any offer which is not available from DOM
    $('.offer-is-not-available').remove();
    
    // Load offer locations on to the map
    $('.offer-location .modal').each(function() {
      if($(this).children('.offer-for-picker').length == 0) {
        console.log("Elminar");
        $(this).remove();
      } else {
        console.log("Dibujar");
  			var marker = {lat: $(this).parent().attr('data-lat'), lon: $(this).parent().attr('data-lng'), locationID: $(this).parent().attr('id') };
  			map.addCoordinatesAsMarkerToList(marker, function(opts) {
          var id = opts.locationID.split('-');
          window.location = '#/locations/'.concat(id[1]);
  			});
      }
    });
    

	} else if($.isDefined('#offer-show')) {
		var offer = new Offer();
		Path.map("#/").to(offer.hideProposals);
    Path.map('#/proposals/:id').to(offer.showProposal);
    
    Path.root('#/');
		Path.listen();
	}
  
  if($.isDefined('#new-offer')) {
    $('.hoverable').on('click', function() {
      $($(this).children('.content-editable')[0]).fadeIn(200);
      $($(this).children('.content-visible')[0]).hide();
    });
    
    $('.reciclables-list-group .list-group-item').on('click', function() {
      $('.reciclables-list-group .list-group-item').removeClass('active');
      $(this).addClass('active');
      $(this).find('input:radio')[0].click();
    });
  }
  
});