#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "noreply@recyclo.mx"
  
  def send_message_email(user, message)
    if user == message.proposal.offer.user
      @to_user = message.proposal.user
      @from_user = message.proposal.offer.user
    else
      @from_user = message.proposal.user
      @to_user = message.proposal.offer.user
    end
    
    @message = message
    mail(to: @to_user.email, subject: "#{@from_user.full_name} te ha enviado un mensaje en Recyclo")
  end
  
  def send_proposal_email(proposal)
    @to_user = proposal.offer.user
    @from_user = proposal.user
    @proposal = proposal
    mail(to: @to_user.email, subject: "#{@from_user.full_name} está interesado en un reciclable que ofreces")
  end
  
  def notify_picker_about_proposal_status_change_email(proposal)
    @to_user = proposal.user
    @from_user = proposal.offer.user
    @proposal = proposal
    mail(to: @to_user.email, subject: "#{@from_user.full_name} ha tomado una decisión sobre tu propuesta")
  end
  
end
