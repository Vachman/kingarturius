class RemovePriceFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :price
    remove_column :events, :date
  end
end
