#encode: utf-8
module WelcomeHelper
  
  def localized_material(kind)
    if kind.eql?('PET')
      "plástico"
    elsif kind.eql?('paper')
      "papel"
    elsif kind.eql?('metal')
      "metal"
    elsif kind.eql?('glass')
      "vidrio"
    end
  end
end
