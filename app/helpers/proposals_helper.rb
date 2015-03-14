module ProposalsHelper
  def current_user_is_a_picker_for(offer)
    !current_user.nil? && current_user.is_a_picker? && current_user == offer.selected_proposal.user
  end
  
  def current_user_is_a_giver_of(offer)
    !current_user.nil? && current_user.is_a_giver? && current_user == offer.user
  end
end
