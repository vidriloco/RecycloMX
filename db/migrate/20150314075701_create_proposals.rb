class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer     :offer_id
      t.integer     :status
      t.integer     :user_id
      t.timestamps
    end
  end
end
