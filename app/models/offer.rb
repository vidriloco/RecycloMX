#encoding: utf-8
class Offer < ActiveRecord::Base
  mount_uploader :offer_image, OfferImageUploader
  has_many :appointments
  belongs_to :user
  belongs_to :location
  
  def self.materials 
    {1 => "Plásticos", 2 => "Vidrio", 3 => "Papel y cartón", 4 => "Metal", 5 => "Fierro viejo"}
  end
  
  def self.materials_sym
    { 1 => :pet, 2 => :glass, 3 => :paper, 4 => :metal, 5 => :fierro }
  end
  
  def self.quantifiable_type_sym
    { 1 => :pieces, 2 => :kgs }
  end
  
  def self.new_with(params, current_user)
    if Location.is_valid?(params[:location])
      location = Location.new_with(params.delete(:location))
      params[:location_id] = location.id if location.save 
    end
    
    return Offer.new(params.merge(user_id: current_user.id, location_id: current_user.location.id)) unless current_user.nil?
    Offer.new(params)
  end
  
  def self.assign_user(id, user)
    offer = Offer.find(id)
    offer.update_attribute(:user_id, user.id)
    offer.location.update_attribute(:user_id, user.id)
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
  
  def location_string
    "#{location.id}:#{location.lat}:#{location.lon}"
  end
end
