// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require path
//= require concerns/extensions
//= require concerns/gmap
//= require concerns/core
//= require map
//= require deposits
//= require offers
//= require users
//= require shared
//= require jquery.animate-enhanced.min
//= require jquery.easing.1.3
//= require jquery.superslides.min
//= require welcome

$(document).ready(function() {
    $('#locate-me-good').on('click', function() {
        mixpanel.track("Attempted to locate", {address_ip: userip});
    });
    
    $('#how-it-works').on('click', function() {
        mixpanel.track("Saw how it works", {address_ip: userip});
    });
    
    $('#close-how-it-works').on('click', function() {
        mixpanel.track("Close how it works", {address_ip: userip});
    });
});