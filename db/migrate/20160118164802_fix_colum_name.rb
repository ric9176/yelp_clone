class FixColumName < ActiveRecord::Migration
  def change
    rename_column :restaurants, :descrition, :description
  end
end
