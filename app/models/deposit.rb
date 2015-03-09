class Deposit < ActiveRecord::Base
  include Geography
  belongs_to :user
  
  attr_accessor :lat, :lon
  
  before_validation :apply_coordinates
  
  def apply_coordinates
    self.apply_geo({"lon" => lon, "lat" => lat})
  end
  
  def lat
    return @lat unless @lat.nil?
    return coordinates.lat unless coordinates.nil?
  end
  
  def lon
    return @lon unless @lon.nil?
    return coordinates.lon unless coordinates.nil?
  end
  
  private
  
  rails_admin do 
    label do
      I18n.t('models.deposit.name')
    end
    
    list do      
      field :name do
        label I18n.t('models.deposit.fields.name')
      end
      
      field :lat do 
        label I18n.t('models.deposit.fields.lat')
      end
      
      field :lon do
        label I18n.t('models.deposit.fields.lon')
      end
      
      field :user do 
        label I18n.t('models.deposit.fields.user')
      end      
    end
    
    show do
      field :name do
        label I18n.t('models.deposit.fields.name')
      end
      
      field :details do
        label I18n.t('models.deposit.fields.details')
        
        pretty_value do
          value.html_safe
        end
      end
      
      field :user do 
        label I18n.t('models.deposit.fields.user')
      end  
      
      field :lat do 
        label I18n.t('models.deposit.fields.lat')
      end
      
      field :lon do
        label I18n.t('models.deposit.fields.lon')
      end
    end
    
    edit do
      field :name do
        label I18n.t('models.deposit.fields.name')
      end
      
      field :details, :ck_editor do
        label I18n.t('models.deposit.fields.details')
      end
      
      field :user do 
        label I18n.t('models.deposit.fields.user')
      end  
      
      field :lat do 
        label I18n.t('models.deposit.fields.lat')
        help I18n.t('admin.form.required')
      end
      
      field :lon do
        label I18n.t('models.deposit.fields.lon')
        help I18n.t('admin.form.required')
      end
      
      field :map do
        help I18n.t('models.deposit.fields.map')
        def render
          bindings[:view].render :partial => 'deposits/admin/map', :locals => {:field => self, :form => bindings[:form]}
        end
      end
    end
    
  end
end
