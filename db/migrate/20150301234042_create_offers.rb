class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer       :kind
      t.decimal       :quantity
      t.integer       :location_id
      t.integer       :user_id
      t.text          :details
      t.boolean       :published, default: false
      t.integer       :quantifiable_type
      t.timestamps
    end
  end
end
