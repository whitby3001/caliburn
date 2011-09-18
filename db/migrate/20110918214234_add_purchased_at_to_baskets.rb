class AddPurchasedAtToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :purchased_at, :datetime
  end
end
