class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer       :offer_id
      t.datetime      :meeting_time
      t.string        :notes
      t.timestamps
    end
  end
end
