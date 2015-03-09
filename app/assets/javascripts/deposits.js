$(document).ready(function() {
	if($.isDefined('#deposits-list')) {
		var deposits = $('.deposit');
		for(var i = 0 ; i < deposits.length ; i++) {
			var deposit = $(deposits[i]);
			var marker = {lat: deposit.attr('data-lat'), lon: deposit.attr('data-lng'), domId: deposit.attr('id') };
			map.addCoordinatesAsMarkerToList(marker, function(opts) {
				var modalID = '#'.concat(opts.domId).concat(' .modal');
				$(modalID).modal('toggle');
			});
		}
	}
});