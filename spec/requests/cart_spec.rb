# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:usr) { create(:user) }
  let(:crt) { create(:cart, user_id: usr.id) }

  describe 'DELETE #destroy' do
    it 'deletes cart (status)' do
      delete cart_path(crt)
      expect(response).to have_http_status(:redirect)
    end

    it 'deletes cart (route)' do
      delete cart_path(crt)
      expect(response).to redirect_to(root_path)
    end

    it 'deletes cart (find)' do
      get cart_path('abc')
      id = Cart.last.id

      delete cart_path(id)

      expect(Cart.find_by(id: id)).to be_nil
    end

    it 'deletes cart (count)' do
      expect { delete cart_path(crt) }.to change(Cart, :count).by(1)
    end
  end
end
