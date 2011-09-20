class AddDasherizedNameToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :dasherized_name, :string
    Category.all.each {|c| c.update_attributes(:dasherized_name => c.name.downcase.gsub(/[^a-z0-9]+/i, '-'))}
  end
  
  def down
    remove_column :categories, :dasherized_name
  end
end
