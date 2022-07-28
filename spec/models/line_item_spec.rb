# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:usr) { create(:user) }
  let(:prod) { create(:product, user: usr) }
  let(:crt) { create(:cart) }
  let(:li) { create(:line_item, product: prod, cart: crt) }

  describe 'validations' do
    describe '#quantity' do
      it { is_expected.to allow_value('testquantity').for(:quantity) }
    end
  end

  describe 'associations' do
    describe 'when line item belongs to a product' do
      it { is_expected.to belong_to(:product) }
    end

    describe 'when line item belongs to a cart' do
      it { is_expected.to belong_to(:cart) }
    end

    describe 'when line item belongs to a order' do
      it { is_expected.to belong_to(:order).optional }
    end
  end

  describe 'testing total_price function' do
    it 'total_price function is valid' do
      expect(li.total_price).to eq(400)
    end
  end
end
