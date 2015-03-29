class ProposalsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @proposal = Proposal.new(proposal_params)
    UserMailer.send_proposal_email(@proposal).deliver if @proposal.save
    
    redirect_to url_for_offer_with_location(@proposal)
  end
  
  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update_attributes(proposal_params)
      UserMailer.notify_picker_about_proposal_status_change_email(@proposal).deliver 
      flash[:notice] = "Tu propuesta ha sido actualizada!"
    end
    redirect_to offer_path(@proposal.offer)
  end
  
  private
  
  def proposal_params
    params.require(:proposal).permit(
      :status, 
      :offer_id,
      :user_id,
      messages_attributes: [:body, :user_id]
    )
  end
  
  def url_for_offer_with_location(proposal)
    "#{offers_path}#/locations/#{proposal.offer.location.id}/collect/#{proposal.offer.id}"
  end
  
end
