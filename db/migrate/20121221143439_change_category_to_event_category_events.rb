class ChangeCategoryToEventCategoryEvents < ActiveRecord::Migration
  def change
    rename_column :events, :category, :event_category
  end
end