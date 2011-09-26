class AddBarcodeToProducts < ActiveRecord::Migration
  def up
    add_column :products, :barcode, :string
    
    Product.all.each do |p|
      ean = p.ean.blank? ? nil : p.ean
      upc = p.upc.blank? ? nil : p.upc
      jan = p.jan.blank? ? nil : p.ean
      isbn = p.isbn.blank? ? nil : p.isbn
      p.update_attributes(:barcode => (ean || upc || jan || isbn))
    end
    
    remove_column :products, :ean
    remove_column :products, :upc
    remove_column :products, :jan
    remove_column :products, :isbn
  end
  
  def down
    remove_column :products, :barcode
    
    add_column :products, :ean, :string
    add_column :products, :upc, :string
    add_column :products, :jan, :string
    add_column :products, :isbn, :string
  end
end
