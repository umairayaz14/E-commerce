# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :description, presence: true
  validates :name, presence: true
end
