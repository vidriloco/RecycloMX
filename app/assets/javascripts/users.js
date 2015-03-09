Activity = function() {
  thisInstance = this;
  
  this.showPublished = function() {
    $('.no-published').addClass('hidden');
    $('.no-unpublished').addClass('hidden');
    
    $('.publishing-button').removeClass('active');
    $('#published-button').addClass('active');
    
    $('.published').removeClass('hidden');
    $('.unpublished').addClass('hidden');
    
    if($('.published').length == 0) {
      $('.no-published').removeClass('hidden');
    }
    
    hideCollectPanelForAll();
  }
  
  this.hidePublished = function() {
    $('.no-published').addClass('hidden');
    $('.no-unpublished').addClass('hidden');
    
    $('.publishing-button').removeClass('active');
    $('#unpublished-button').addClass('active');
    
    $('.published').addClass('hidden');
    $('.unpublished').removeClass('hidden');
    
    if($('.unpublished').length == 0) {
      $('.no-unpublished').removeClass('hidden');
    }
    
    hideCollectPanelForAll();
  }
  
  this.showCollectSettingsOnPublished = function() {
    thisInstance.showPublished();
    showCollectPanelForOffer(this.params['id']);
  }
  
  this.showCollectSettingsOnUnpublished = function() {
    thisInstance.hidePublished();
    showCollectPanelForOffer(this.params['id']);
  }
  
  var hideCollectPanelForAll = function(id) {
    $('.collect-panel').addClass('hidden');
    $(' .collect-panel-hide').addClass('hidden');
    $(' .collect-panel-show').removeClass('hidden');
  }
  
  var showCollectPanelForOffer = function(id) {
    hideCollectPanelForAll();
    $('#offer-'.concat(id).concat(' .collect-panel')).removeClass('hidden');
    $('#offer-'.concat(id).concat(' .collect-panel-hide')).removeClass('hidden');
    $('#offer-'.concat(id).concat(' .collect-panel-show')).addClass('hidden');
  }
}

$(document).ready(function() {
	if($.isDefined('#activity')) {
		var activity = new Activity();
		Path.map("#/").to(activity.showPublished);
		Path.map("#/published").to(activity.showPublished);
		Path.map("#/unpublished").to(activity.hidePublished);
    
		Path.map("#/published/:id/collect").to(activity.showCollectSettingsOnPublished);
		Path.map("#/unpublished/:id/collect").to(activity.showCollectSettingsOnUnpublished);
    
		Path.root("#/published");
		Path.listen();
	}
});