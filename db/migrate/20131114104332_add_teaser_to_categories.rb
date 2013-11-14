class AddTeaserToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :teaser, :text
  end
end
