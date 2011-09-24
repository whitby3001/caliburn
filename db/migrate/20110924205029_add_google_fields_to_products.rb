class AddGoogleFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :upc, :integer
    add_column :products, :ean, :integer
    add_column :products, :jan, :integer
    add_column :products, :isbn, :integer
    add_column :products, :brand, :string
    add_column :products, :mpn, :string
    add_column :products, :condition, :string
    add_column :products, :google_category, :string
    
    add_column :categories, :google_category, :string
  end
end
