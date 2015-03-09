#encoding: utf-8

User.create!(:full_name => "Alejandro", :email => "alex@root.com", :password => "12345678", :password_confirmation => "12345678", :role => User.roles[:superuser])

@d1 = User.create!(full_name: "Lee", email: "donador1@example.com", password: "donador1", password_confirmation: "donador1", role: User.roles[:giver])
@d2 = User.create!(full_name: "Luisa", email: "donador2@example.com", password: "donador2", password_confirmation: "donador2", role: User.roles[:giver])
@r3 = User.create!(full_name: "Josefina", email: "recolector1@example.com", password: "recolector1", password_confirmation: "recolector1", role: User.roles[:picker])

uploader = AvatarUploader.new(@d1, :avatar)
File.open(File.open(Rails.root.join(["public", "sample_images", "giver1.jpg"].join("/")))) do |f|
  uploader.store!(f)
end
@d1.avatar = uploader
@d1.save

uploader = AvatarUploader.new(@d2, :avatar)
File.open(File.open(Rails.root.join(["public", "sample_images", "giver2.jpg"].join("/")))) do |f|
  uploader.store!(f)
end
@d2.avatar = uploader
@d2.save

uploader = AvatarUploader.new(@r3, :avatar)
File.open(File.open(Rails.root.join(["public", "sample_images", "messenger.jpg"].join("/")))) do |f|
  uploader.store!(f)
end
@r3.avatar = uploader
@r3.save

# Offer 1
@o1 = Offer.new_with({ 
  kind: Offer.materials_sym.invert[:glass], 
  quantity: "50", 
  details: "Muchos envases de vidrio, entre cervezas, refrescos.",
  quantifiable_type: Offer.quantifiable_type_sym.invert[:pieces],
  published: true
}, nil)

@o1.location = Location.new_with({
    :coordinates_lat => 19.397694,
    :coordinates_lon => -99.150840,
    :address => "Una ubicación válida",
    :user_id => @d1.id
})
@o1.user_id = @d1.id
@o1.appointments << [Appointment.new(meeting_time: DateTime.now+3.days, notes: "A partir de esta hora hasta las 10 PM")]

uploader = OfferImageUploader.new(@o1, :offer_image)
File.open(File.open(Rails.root.join(["public", "sample_images", "glass.jpg"].join("/")))) do |f|
  uploader.store!(f)
end

@o1.offer_image = uploader
@o1.save!

# Offer 2
@o2 = Offer.new_with({ 
  kind: Offer.materials_sym.invert[:paper], 
  quantity: "10", 
  details: "Periódicos y revistas",
  quantifiable_type: Offer.quantifiable_type_sym.invert[:kgs],
  published: true
}, nil)

@o2.location = Location.new_with({
    :coordinates_lat => 19.427565,
    :coordinates_lon => -99.145004,
    :address => "Una ubicación válida",
    :user_id => @d2.id
})
@o2.user_id = @d2.id
@o2.appointments << [Appointment.new(meeting_time: DateTime.now+2.days-8.hours)]

uploader = OfferImageUploader.new(@o2, :offer_image)
File.open(File.open(Rails.root.join(["public", "sample_images", "paper.jpg"].join("/")))) do |f|
  uploader.store!(f)
end

@o2.offer_image = uploader
@o2.save!


# Offer 3
@o3 = Offer.new_with({ 
  kind: Offer.materials_sym.invert[:metal], 
  quantity: "100", 
  details: "Latas de cerveza y de refresco",
  quantifiable_type: Offer.quantifiable_type_sym.invert[:pieces],
  published: true,
}, nil)

@o3.location = @d2.location
@o3.user_id = @d2.id
@o3.appointments << [Appointment.new(meeting_time: DateTime.now+12.days-3.hours)]

uploader = OfferImageUploader.new(@o3, :offer_image)
File.open(File.open(Rails.root.join(["public", "sample_images", "latas.jpg"].join("/")))) do |f|
  uploader.store!(f)
end

@o3.offer_image = uploader
@o3.save!


