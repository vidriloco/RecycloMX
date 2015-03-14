class MessagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "Tu mensaje ha sido enviado! Espera la respuesta del donador"
      redirect_to offer_path(@message.proposal.offer).concat("#/proposals/#{@message.proposal.id}")
    else
      render nothing: true
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(
      :body, 
      :proposal_id,
      :user_id
    )
  end
  
  def url_for_message_sent_by_collector(message)
    "#{offers_path}#/locations/#{message.proposal.offer.location.id}/collect/#{message.proposal.offer.id}"
  end
end
