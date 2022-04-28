class Product < ApplicationRecord
  belongs_to :user


  has_many_attached :images
  validate :images, :images_type

  private

  def images_type
   images.each do |img|
     if !img.blob.content_type.in?(%('image/jpeg image/png'))
       img.purge
       errors.add(:images, 'Please upload in jpeg or png format')
     end
    end
  end
end
