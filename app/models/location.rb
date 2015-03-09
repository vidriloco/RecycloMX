class Location < ActiveRecord::Base
  include Geography
  
  has_many :offers
  belongs_to :user
  
  validates :address, :coordinates, presence: true
  
  def self.is_valid?(params)
    return !params.nil? && !params[:coordinates_lat].blank? && !params[:coordinates_lon].blank?
  end
  
  def self.extract_coords(params)
    return {} if params.blank?
    {
      "lat" => params.delete(:coordinates_lat),
      "lon" => params.delete(:coordinates_lon)
    }
  end
  
  def self.new_with(params)
    location_params = Location.extract_coords(params)
    location = Location.new(params)
    location.apply_geo(location_params)
    location
  end
  
  def update_with(params)
    new_location = Location.extract_coords(params)
    self.apply_geo(new_location) unless new_location["lat"].blank? && new_location["lon"].blank?
    self.update_attributes(params)
  end
  
  def short_address
    address[0,50].concat(' ...')
  end
  
  def lat
    return nil if coordinates.blank?
    coordinates.lat
  end
  
  def lon
    return nil if coordinates.blank?
    coordinates.lon
  end
end
