class AddAddressIntoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :street, :string
    add_column :users, :postal_code, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :country, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
