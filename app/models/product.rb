# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :line_items, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validate :images, :images_type

  private

  def images_type
    return unless images.attached?

    images.each do |img|
      unless img.blob.content_type.in?(%('image/jpeg image/png'))
        img.purge
        errors.add(:images, 'Please upload in jpeg or png format')
      end
    end
  end
end
