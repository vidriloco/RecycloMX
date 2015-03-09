$(document).ready(function() {

	if($.isDefined('#landing-page')) {
    $('#slides').superslides({
      animation: 'fade',
			play: 4000,
			pagination: false
    });
	}
	
});