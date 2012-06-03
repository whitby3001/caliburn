class AddIndexes < ActiveRecord::Migration
  def up
    add_index :additional_images, :id
    add_index :baskets, :id
    add_index :categories, :id
    add_index :line_items, :id
    add_index :payment_notifications, :id
    add_index :products, :id
    add_index :products, :category_id
    add_index :line_items, :basket_id
    add_index :line_items, :product_id
    add_index :payment_notifications, :basket_id
    add_index :additional_images, :product_id
    add_index :users, :id
    add_index :categories, :dasherized_name
    add_index :products, :quantity
    add_index :products, :featured
    add_index :products, :name
    add_index :products, [:quantity, :category_id, :name]
    add_index :products, [:quantity, :name]
    add_index :categories, :lft
  end

  def down
    remove_index :additional_images, :id
    remove_index :baskets, :id
    remove_index :categories, :id
    remove_index :line_items, :id
    remove_index :payment_notifications, :id
    remove_index :products, :id
    remove_index :products, :category_id
    remove_index :line_items, :basket_id
    remove_index :line_items, :product_id
    remove_index :payment_notifications, :basket_id
    remove_index :additional_images, :product_id
    remove_index :users, :id
    remove_index :categories, :dasherized_name
    remove_index :products, :quantity
    remove_index :products, :featured
    remove_index :products, :name
    remove_index :products, [:quantity, :category_id, :name]
    remove_index :products, [:quantity, :name]
    remove_index :categories, :lft
  end
end
