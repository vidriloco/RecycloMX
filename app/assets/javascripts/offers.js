Offer = function() {
  thisInstance = this;
  
  this.showLocation = function() {
    var id = this.params['id'];
    mixpanel.track("Checked location with ID:".concat(id), {address_ip: userip});
    loadLocation(id);
  }
  
  this.collectForOffer = function() {
    var id = this.params['id'];
    var offerId = this.params['offer_id'];
    loadLocation(id);
    
		var offerID = '#offer-'.concat(offerId).concat(' .modal-footer');
    $(offerID.concat(' .collect')).fadeIn(300);
    $(offerID.concat(' .actions')).hide();
    mixpanel.track("Considering collecting offer with ID:".concat(offerID), {address_ip: userip});
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
  if($.isDefined('#offers-list') || $.isDefined('#deposits-list')) {
    $('.container-right .legend .info').on('click', function() {
      if($('.container-right .instructions').is(':visible'))
        $('.container-right .instructions').hide();
      else
        $('.container-right .instructions').show();
    });
  }
  
  
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
        $(this).remove();
      } else {
  			var marker = {iconName: $($(this).children('.offer-for-picker')[0]).attr('data-icon'), lat: $(this).parent().attr('data-lat'), lon: $(this).parent().attr('data-lng'), locationID: $(this).parent().attr('id') };
  			map.addCoordinatesAsMarkerToList(marker, function(opts) {
          var id = opts.locationID.split('-');
          window.location = '#/locations/'.concat(id[1]);
  			});
      }
    });
    
    $('.container-right .legend .disable').on('click', function() {
      $('.container-right .legend .reciclables-list-group').fadeOut();
      $(this).hide();
      $('.container-right .legend .enable').show();
    });
    
    $('.container-right .legend .enable').on('click', function() {
      $('.container-right .legend .reciclables-list-group').fadeIn();
      $('.container-right .legend .disable').show();
      $(this).hide();
    });
    
    setTimeout(function() {
      $('.container-right .legend .disable').click();
    }, 700);
    
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