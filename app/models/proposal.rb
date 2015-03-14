class Proposal < ActiveRecord::Base
  has_many :messages
  belongs_to :offer
  belongs_to :user
  
  accepts_nested_attributes_for :messages
  
  validates :offer_id, :user_id, :status, presence: true
  
  def self.statuses
    { 1 => :available, 2 => :rejected, 3 => :accepted }
  end
  
  def self.status_for
    self.statuses.invert
  end
  
  def is_accepted?
    Proposal.status_for[:accepted] == status
  end
  
  def is_rejected?
    Proposal.status_for[:rejected] == status
  end
  
  def is_available?
    Proposal.status_for[:available] == status
  end
  
  def offer_is_available?
    offer.proposals.where(status: Proposal.status_for[:accepted]).empty?
  end
end
