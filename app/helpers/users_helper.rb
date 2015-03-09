module UsersHelper
  def location_set?(location)
    return nil if location.nil?
    return "initial-location-set" if !location.lat.blank? and !location.lon.blank?
  end
end
