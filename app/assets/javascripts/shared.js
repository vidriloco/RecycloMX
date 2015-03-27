$(document).ready(function() {
  if($.isDefined('.alert-container')) {
    setTimeout(function() {
      $('.alert-container').slideDown(500);
    }, 500);
  }
});