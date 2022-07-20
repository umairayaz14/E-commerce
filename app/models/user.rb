# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validate :avatar, :avatar_type

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :avatar

  private

  def avatar_type
    return unless avatar.attached? && !avatar.blob.content_type.in?(%('image/jpeg image/png'))

    avatar.purge
    errors.add(:avatars, 'Please upload in jpeg or png format')
  end
end
