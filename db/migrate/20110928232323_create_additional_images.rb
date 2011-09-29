class CreateAdditionalImages < ActiveRecord::Migration
  def change
    create_table :additional_images do |t|
      t.integer :product_id
      t.string :image_file_name
      t.string :image_content_type
      t.string :image_file_size
      t.string :image_updated_at
      t.timestamps
    end
  end
end
