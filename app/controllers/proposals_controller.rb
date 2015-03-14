class ProposalsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      flash[:notice] = "Tu propuesta ha sido enviada! Espera la respuesta del donador"
    end
    redirect_to url_for_offer_with_location(@proposal)
  end
  
  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update_attributes(proposal_params)
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
