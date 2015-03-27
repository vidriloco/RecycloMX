class Message < ActiveRecord::Base
  
  belongs_to :proposal
  belongs_to :user
  
  validates :body, length: { minimum: 2 }
  
  def self.message_types
    { 1 => :first_contact, 2 => :declined, 3 => :accepted, 4 => :reply }
  end
  
  def self.message_type
    self.message_types.invert
  end
  
  def is_first_contact?
    self.kind == Message.message_type[:first_contact]
  end
  
end
