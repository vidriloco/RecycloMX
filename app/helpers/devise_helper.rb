module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?
    
    html_error_for(resource.errors.full_messages[0])
  end
  
  def devise_sign_in_errors!
    return '' if flash.empty?
    
    html_error_for(flash.first[1])
  end
  
  def html_error_for(message)
    html = <<-HTML
    <div class="alert-container">
    	<div class="alert alert-dismissible alert-danger">
    		<button class="close" data-dismiss="alert" type="button">×</button>
    		<p class="centered">#{message}</p>
    	</div>
    </div>
    HTML

    html.html_safe
  end
end