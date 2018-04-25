class Style < ApplicationRecord
  belongs_to :client
  has_attached_file :image, 
                    styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png",
                    :storage => :cloudinary,
                    :path => ':id/:style/:filename'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def abbreviated_name
    letters = self.name.chars
    letters.length > 20 ? abb_name = letters[0..19].push('...') : abb_name = letters
    abb_name.join('')
  end

end
