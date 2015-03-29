$(document).ready(function() {

	if($.isDefined('#landing-page')) {
    $('#slides').superslides({
      animation: 'fade',
			play: 6000,
			pagination: false
    });
    
    setTimeout(function() {
      $('.fixed-container').fadeIn('slow');
    }, 500);
    
    var showMoreInfo = function() {
      $('.floating-navbar').hide();
      $('.fixed-container').hide();
      $('.fixed-modal').fadeIn('slow');
    }
    
    var hideMoreInfo = function() {
      $('.floating-navbar').fadeIn();
      $('.fixed-container').fadeIn();
      $('.fixed-modal').hide();
    }
    
    $('.show-more-info').on('click', showMoreInfo);
    $('.hide-more-info').on('click', hideMoreInfo);
    
	}
	
});