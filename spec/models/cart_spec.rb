# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:usr) { create(:user) }
  let(:crt) { create(:cart, user_id: usr.id) }

  describe 'associations' do
    describe 'when cart has many line items' do
      it { is_expected.to have_many(:line_items).dependent(:destroy) }
    end

    describe 'when cart has many products' do
      it { is_expected.to have_many(:products).through(:line_items) }
    end
  end

  describe 'testing cart functions' do
    it 'total_price function is valid' do
      p = create(:product, user: usr)
      create(:line_item, cart: crt, product: p)
      expect(crt.sub_total).to eq(400)
    end

    it 'total_quantity function is valid' do
      p = create(:product, user: usr)
      create(:line_item, cart: crt, product: p)
      expect(crt.total_quantity).to eq(2)
    end
  end
end
