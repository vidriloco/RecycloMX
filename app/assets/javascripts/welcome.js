$(document).ready(function() {

	if($.isDefined('#landing-page')) {
    $('#slides').superslides({
      animation: 'fade',
			play: 6000,
			pagination: false
    });
	}
	
});