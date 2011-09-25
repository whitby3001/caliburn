class ChangeCodesToStrings < ActiveRecord::Migration
  def change
    change_column :products, :upc, :string
    change_column :products, :ean, :string
    change_column :products, :jan, :string
    change_column :products, :isbn, :string
  end
end
