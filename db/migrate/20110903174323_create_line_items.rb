class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :basket_id
      t.integer :quantity, :default => 1
      t.decimal :unit_price

      t.timestamps
    end
  end
end
