class AddOfferImageToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :offer_image, :string
  end
end
