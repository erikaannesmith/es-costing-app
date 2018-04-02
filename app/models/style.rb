class Style < ApplicationRecord
  belongs_to :client
  has_attached_file :image, 
                    styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png",
                    :storage => :cloudinary,
                    :path => ':id/:style/:filename'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
