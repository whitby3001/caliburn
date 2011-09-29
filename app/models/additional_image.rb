class AdditionalImage < ActiveRecord::Base
  belongs_to :product
  
  has_attached_file :image, 
                    :styles => { :medium => ["300x300>", :png], :small => ["200x200", :png], :thumb => ["96x96", :png] },
                    :convert_options => {:thumbnail => "-background transparent -gravity center -extent 96x96", :small => "-background transparent -gravity center -extent 200x200"},
                    :storage => (Rails.env.production? ? :s3 : :filesystem), 
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => (Rails.env.production? ? "/:class/:attachment/:id/:style/:filename" : ":rails_root/public/system/additional_images/:id/:style/:filename"),
                    :url => "/system/additional_images/:id/:style/:filename"
end
