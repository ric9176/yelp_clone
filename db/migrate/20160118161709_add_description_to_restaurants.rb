class AddDescriptionToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :descrition, :text
  end
end
