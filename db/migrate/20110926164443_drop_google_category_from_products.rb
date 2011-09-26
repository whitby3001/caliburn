class DropGoogleCategoryFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :google_category
  end

  def down
    add_column :products, :google_category, :string
  end
end
