class User < ActiveRecord::Base  
  mount_uploader :avatar, AvatarUploader
  
  serialize :roles, Array
  
  validates :full_name, :email, :presence => true
  validates :password, :role, :presence => true, on: 'create'
  validates :email, :uniqueness => true, on: 'create'
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: 'create'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :location, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :deposits
  has_many :proposals, dependent: :destroy
  has_many :messages, through: :proposals
    
  def offers_through_proposals
    proposals.includes(:offer).map(&:offer)
  end
  
  def self.roles
    { superuser: 0, picker: 1, giver: 2}
  end
  
  def has_role?(role_name)
    role == User.roles[role_name]
  end
  
  def sym_role
    User.roles.invert[self.role]
  end
  
  def role_enum
    User.roles_for_user(self)
  end
  
  def self.roles_for_user(user)
    trans_roles = User.roles.to_a.map { |ro| [I18n.t("models.user.roles.#{ro[0]}"), ro[1]]  }
    return trans_roles[1] if user.has_role?(:superuser)
    return [trans_roles.last] if user.has_role?(:participant)
    trans_roles
  end
  
  def should_update_profile?
    phone.blank? || bio.blank?
  end
  
  def update_with(params)
    params.delete(:password) if params[:password].blank?
    location_params = params.delete(:location)
    
    if updated=update_attributes(params)
      if self.location.nil?
        new_location = Location.new_with(location_params)
        new_location.user_id = self.id
        new_location.save if new_location.valid?
      else
        self.location.update_with(location_params)
      end    
    end
    updated
  end
  
  def location_lat
    return nil if self.location.nil?
    self.location.lat
  end
  
  def location_lon
    return nil if self.location.nil?
    self.location.lon
  end
  
  def is_a_giver?
    self.role == User.roles[:giver]
  end
  
  def is_a_picker?
    self.role == User.roles[:picker]
  end
  
  def unpublished_offers?
    offers.count(published: false) > 0
  end
  
  # Used for the naming association on rails_adminh
  def title
    email
  end
  
  private
  
  rails_admin do 
    label do
      I18n.t('models.user.name')
    end
    
    list do      
      
      field :full_name do
        label I18n.t('models.user.fields.full_name')
      end
      
      field :role do
        label I18n.t('models.user.fields.role')
      end
      
      field :email do
        label I18n.t('models.user.fields.email')
      end

      field :last_sign_in_at do
        label I18n.t('models.user.fields.last_sign_in_at')
      end
      
      field :sign_in_count do
        label I18n.t('models.user.fields.sign_in_count')
      end
    end
    
    edit do       

      field :full_name do
        label I18n.t('models.user.fields.full_name')
      end
      
      field :role, :enum do
        label I18n.t('models.user.fields.role')
        
        enum do
          User.roles
        end
      end
      
      field :email do
        label I18n.t('models.user.fields.email')
      end
      
      field :password do
        label I18n.t('models.user.fields.password')
      end
      
      field :password_confirmation do
        label I18n.t('models.user.fields.password_confirmation')
      end
    end
  end
end
