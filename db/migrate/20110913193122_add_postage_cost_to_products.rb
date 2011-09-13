class AddPostageCostToProducts < ActiveRecord::Migration
  def change
    add_column :products, :postage_cost, :decimal, :precision => 8, :scale => 2
  end
end
