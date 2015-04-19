class AddVpasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :v_password, :string
  end
end
