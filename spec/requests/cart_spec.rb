# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:usr) { create(:user) }
  let(:crt) { create(:cart, user_id: usr.id) }

  describe 'DELETE #destroy' do
    it 'deletes cart' do
      delete cart_path(crt)
      expect(response).to have_http_status(:redirect)
    end
  end
end
