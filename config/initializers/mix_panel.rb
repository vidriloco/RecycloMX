require 'mixpanel-ruby'

class Tracker
  
  @@instance = Mixpanel::Tracker.new("6ed8f50df13793758a40ecd485dd688e")
  
  def self.instance
    @@instance
  end 
  
  def self.track_user(user, opts)
    @@instance.people.set(user, opts);
  end
  
  def self.track_event(ip, event, opts={})
    @@instance.track(ip, event, {
      logged_in: false,
      address_ip: ip
    }.merge(opts))
  end
  
  def self.track_event_for_user(user, event, opts={})
    @@instance.track(user, event, {
      logged_in: true,
      user_email: user.email
    }.merge(opts))
  end
  
  def self.offer_info(offer)
    {
      offer_name: offer.name, 
      offer_id: offer.id
    }
  end
  
  def self.track_new_offer(user, ip)
    unless user.nil?
      Tracker.track_event_for_user(user, 'New offer page', {address_ip: ip})
    else
      Tracker.track_event(ip, 'New offer page')
    end
  end
  
  def self.track_offer_created_success(user, offer, ip)
    unless user.nil?
      Tracker.track_event_for_user(user, "Offer created", {address_ip: ip}.merge(self.offer_info(offer)))
    else
      Tracker.track_event(ip, "First offer created", self.offer_info(offer))
    end
  end
  
  def self.track_offer_created_failure(user, ip)
    unless user.nil?
      Tracker.track_event_for_user(user, 'Could not create offer', {address_ip: ip})
    else
      Tracker.track_event(ip, user.errors.messages)
    end
  end
  
  def self.track_offer_visualization(user, offer, ip)
    unless user.nil?
      Tracker.track_event_for_user(user, "Visualized offer", {address_ip: ip}.merge(self.offer_info(offer)))
    else
      Tracker.track_event(ip, "Visualized offer", self.offer_info(offer))
    end
  end
  
  def self.track_offer_destruction_success(user, offer, ip)
    Tracker.track_event_for_user(user, "Destroyed offer", {address_ip: ip}.merge(self.offer_info(offer)))
  end
  
  def self.track_offer_destruction_failure(user, offer, ip)
    Tracker.track_event_for_user(user, "Failed destroy offer attempt", {address_ip: ip}.merge(self.offer_info(offer)))
  end
  
  def self.track_proposal_created(user, proposal, ip)
    Tracker.track_event_for_user(user, "Proposal created for offer", 
      {address_ip: ip,
       proposal: proposal.id }.merge(self.offer_info(proposal.offer)))
  end
  
  def self.track_proposal_updated_success(user, proposal, ip)
    Tracker.track_event_for_user(user, "Proposal successfully updated for offer", {address_ip: ip, 
       proposal: proposal.id,
       status: proposal.sym_status }.merge(self.offer_info(proposal.offer)))
  end
  
  def self.track_proposal_updated_failure(user, proposal, ip)
    Tracker.track_event_for_user(user, "Proposal failed to update for offer", {address_ip: ip, 
       proposal: proposal.id,
       status: proposal.sym_status }.merge(self.offer_info(proposal.offer)))
  end
  
  def self.track_message_creation_failure(user, message, ip)
    Tracker.track_event_for_user(user, "Message failed to create", {address_ip: ip, 
       proposal: message.proposal.id,
       message: message.id }.merge(self.offer_info(message.proposal.offer)))
  end
  
  def self.track_message_creation_success(user, message, ip)
    Tracker.track_event_for_user(user, "Message succeeded on create", {address_ip: ip, 
      proposal: message.proposal.id,
      message: message.id }.merge(self.offer_info(message.proposal.offer)))
  end
  
  def self.track_user_creation_success(user, ip)
    Tracker.track_user(user.id, {
      name: user.full_name,
      email: user.email,
      role: user.sym_role
    })
    Tracker.track_event_for_user(user, "New user registered", {address_ip: ip, email: user.email, name: user.full_name, role: user.sym_role})
  end
  
  def self.track_user_creation_failure(user, ip)
    Tracker.track_event(ip, "Failed to register user")
  end
  
  def self.track_offer_list_shown(user, ip)
    Tracker.track_event_for_user(user, "Shown list of offers as picker", {address_ip: ip, email: user.email, name: user.full_name})
  end
  
  def self.track_own_user_profile_shown(current_user, user, ip)
    Tracker.track_event_for_user(user, "Visited user profile", {address_ip: ip, own: (current_user == user) })
  end
  
  def self.track_user_updated_profile(current_user, user, params, ip)
    params.delete(:password)
    Tracker.track_user(user.id, {
      name: user.full_name,
      email: user.email,
      role: user.sym_role
    }.merge(params))
    Tracker.track_event_for_user(user, "Profile Updated", params.merge({address_ip: ip}))
  end
  
  def self.track_user_visited_dashboard(user, ip)
    Tracker.track_event_for_user(user, "User visited his dashboard", { address_ip: ip })
  end
  
  def self.track_user_searching_for_deposits(user, ip)
    Tracker.track_event_for_user(user, "User searched for deposits", { address_ip: ip })
  end
end


