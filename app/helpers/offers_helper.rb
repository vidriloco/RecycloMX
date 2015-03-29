#encoding: utf-8
module OffersHelper
  def humanized_title_for(object)
    if object.is_a?(Offer)
      humanized_quantifier = t("offers.quantifiers.#{Offer.quantifiable_type_sym[object.quantifiable_type]}")
      "#{object.quantity.to_i} #{humanized_quantifier.downcase} de #{object.material_kind}".html_safe
    end
  end
  
  def humanized_offer_quantifiables
    Offer.quantifiable_type_sym.invert.to_a.map { |q| [t("offers.quantifiers.#{q[0]}"), q[1]] }
  end
  
  def published_status_for(offer)
    return "published" if offer.published
    "unpublished"
  end
  
  def humanized_offer_appointments_count_for(offer)
    if offer.appointments.size == 1
      "Tiene <b>1</b> fecha de recolección".html_safe
    else
      "Tiene <b>#{offer.appointments.size}</b> fechas de recolección".html_safe
    end
  end
  
  def humanized_offers_count_for(collection)
    if collection.size == 1
      "<b>1</b> reciclable posteado por".html_safe
    else
      "<b>#{collection.count}</b> reciclables posteados por".html_safe
    end
  end
  
  def last_message_for_offer_is_more_than?(offer, days)
    return false if offer.messages.empty?
    ((Time.zone.now-offer.messages.last.created_at) / days) > 1
  end
  
  def errors_for_field?(offer, field)
    offer.errors.each do |error|
      if error.eql?(field)
        return 'has-error'
      end
    end
  end
end
