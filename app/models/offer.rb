#encoding: utf-8
class Offer < ActiveRecord::Base
  mount_uploader :offer_image, OfferImageUploader

  has_many :proposals, dependent: :destroy
  has_many :messages, through: :proposals
  belongs_to :user
  belongs_to :location
  
  validates :kind, :quantity, presence: true
  
  before_validation :check_location
  
  def self.materials 
    {1 => "Plásticos", 2 => "Vidrio", 3 => "Papel y cartón", 4 => "Aluminio y metal", 5 => "Fierro viejo / chatarra"}
  end
  
  def self.materials_sym
    { 1 => :pet, 2 => :glass, 3 => :paper, 4 => :metal, 5 => :fierro }
  end
  
  def self.quantifiable_type_sym
    { 1 => :pieces, 2 => :kgs }
  end
  
  def self.materials_for(symbol)
    Offer.materials[Offer.materials_sym.invert[symbol]]
  end
  
  def self.all_visible_to(current_user)
    Offer.where('offers.user_id != ?', current_user.id).includes(:proposals, :location).group_by(&:location_string)    
  end
  
  def self.new_with(params, current_user)
    location_params = params.delete(:location)
    if Location.is_valid?(location_params)
      location = Location.new_with(location_params)
      location.user = current_user
      params[:location_id] = location.save ? location.id : nil  
    end
    
    params.merge!(user_id: current_user.id) unless current_user.nil?
    params.merge!(location_id: current_user.location.id) if !current_user.nil? and !current_user.location.nil?
    
    Offer.new(params)
  end
  
  def self.assign_user(id, user)
    offer = Offer.find(id)
    offer.update_attribute(:user_id, user.id)
    offer.location.update_attribute(:user_id, user.id)
  end
  
  def name
    humanized_quantifier = I18n.t("offers.quantifiers.#{Offer.quantifiable_type_sym[self.quantifiable_type]}")
    "#{self.quantity.to_i} #{humanized_quantifier.downcase} de #{self.material_kind}"
  end
  
  def material_kind
    Offer.materials[self.kind]
  end
  
  def material_kind_sym
    Offer.materials_sym[self.kind]
  end
  
  def has_appointments?
    appointments.size > 0
  end
  
  def appointments_count_reached_max?
    appointments.size >= 3
  end
  
  def selected_proposal
    proposals.where('status = ?', Proposal.status_for[:accepted]).first
  end
  
  def is_available?
    selected_proposal.nil?
  end
  
  def proposal_from?(from_user, status)
    !proposals.where(user_id: from_user.id, status: Proposal.status_for[status]).first.nil?
  end
  
  def has_proposal_from?(from_user)
    !proposal_issued_by(from_user).nil?
  end
  
  def proposal_issued_by(from_user)
    proposals.where(user_id: from_user.id).first
  end
  
  def proposals_in_context_of(user_context)
    if user_context.is_a_picker?
      proposals.where(user_id: user_context.id)
    else
      proposals
    end
  end
  
  def location_string
    "#{location.id}:#{location.lat}:#{location.lon}"
  end
  
  private
  def check_location
    errors.add(:location, "Necesitas ubicarte en el mapa") if self.location.nil? || self.location.lat.nil? || self.location.lon.nil?
    errors.add(:address, "Escribe tu domicilio") if self.location.nil? || self.location.address.blank?
  end
end
