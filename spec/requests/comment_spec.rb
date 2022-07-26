# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:usr) { create(:user) }
  let(:usr2) { create(:user) }
  let(:prod) { create(:product, user: usr) }
  let(:com) { create(:comment, product: prod, user: usr) }

  describe 'checking comment policy' do
    it 'does not create a new comment as policy is implemented where a user can not comment on own product' do
      sign_in(usr)
      post product_comments_path(prod), params: { comment: { name: 'tests', description: 'testdescription' } }
      # expect(response.status).to have_http_status(:redirect)
      expect(flash[:warning]).to eq('You are not authorized to perform this action.')
    end
  end

  describe 'POST create' do
    it 'creates a comment (flash)' do
      sign_in(usr2)
      post product_comments_path(prod),
           params: { comment: { name: 'tests', description: 'testdescription' }, format: :js }
      expect(flash[:notice]).to eq('Commented successfully')
    end

    it 'creates a comment (status)' do
      sign_in(usr2)
      post product_comments_path(prod),
           params: { comment: { name: 'tests', description: 'testdescription' }, format: :js }
      expect(response).to have_http_status(:ok)
    end

    it 'does not create a comment (flash)' do
      sign_in(usr2)
      post product_comments_path(prod), params: { comment: { name: '', description: 'testdescription' }, format: :js }
      expect(flash[:alert]).to eq('unable to post a comment.')
    end

    it 'does not create a comment (status)' do
      sign_in(usr2)
      post product_comments_path(prod), params: { comment: { name: '', description: 'testdescription' }, format: :js }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE  destroy' do
    it 'deletes comment (status)' do
      sign_in(usr)
      delete product_comment_path(prod, com)
      expect(response).to have_http_status(:redirect)
    end

    it 'deletes comment (flash)' do
      sign_in(usr)
      delete product_comment_path(prod, com)
      expect(flash[:notice]).to eq('Comment was successfully destroyed.')
    end

    it 'does not delete comment (template)' do
      sign_in(usr)
      delete product_comment_path(prod, 999)
      expect(response).to render_template('layouts/not_found')
    end
  end

  describe 'UPDATE  put' do
    it 'updates comment (status)' do
      sign_in(usr)
      patch product_comment_path(prod, com),
            params: { comment: { name: 'umair', description: 'ayaz', user_id: usr.id } }
      expect(response).to have_http_status(:redirect)
    end

    it 'updates comment (flash)' do
      sign_in(usr)
      patch product_comment_path(prod, com),
            params: { comment: { name: 'umair', description: 'ayaz', user_id: usr.id } }
      expect(flash[:notice]).to eq('Comment was successfully updated.')
    end

    it 'does not update comment (status)' do
      sign_in(usr)
      patch product_comment_path(prod, com), params: { comment: { name: '', description: 'ayaz', user_id: usr.id } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not update comment (template)' do
      sign_in(usr)
      patch product_comment_path(prod, com), params: { comment: { name: '', description: 'ayaz', user_id: usr.id } }
      expect(response).to render_template('comments/edit')
    end
  end
end
