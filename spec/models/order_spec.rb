# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    describe 'when order belongs to a user' do
      it { is_expected.to belong_to(:user).optional }
    end

    describe 'when order has many line items' do
      it { is_expected.to have_many(:line_items).dependent(:destroy) }
    end
  end
end
