module MessagesHelper
  def humanized_message_count_for(count)
    if count == 1
      "#{count} mensaje"
    else
      "#{count} mensajes"
    end
  end
end
