class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.point         :coordinates, :geographic => true
      t.string        :address
      t.boolean       :is_default
      t.integer       :user_id
      t.timestamps
    end
  end
end
