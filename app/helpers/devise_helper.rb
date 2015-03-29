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
    render(partial: 'devise/shared/errors', locals: { message: message })
  end
end