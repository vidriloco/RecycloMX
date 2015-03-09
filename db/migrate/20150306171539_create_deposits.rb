class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.point         :coordinates, :geographic => true
      t.string        :name
      t.text          :details
      t.integer       :user_id
      t.timestamps
    end
  end
end
