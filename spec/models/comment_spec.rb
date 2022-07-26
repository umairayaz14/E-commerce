# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    describe '#name' do
      it { is_expected.not_to allow_value('').for(:name) }
      it { is_expected.to allow_value('test').for(:name) }
    end

    describe '#description' do
      it { is_expected.not_to allow_value('').for(:name) }
      it { is_expected.to allow_value('testdescription').for(:name) }
    end
  end

  describe 'associations' do
    describe 'when comment belongs to a user' do
      it { is_expected.to belong_to(:user) }
    end

    describe 'when comment belongs to a product' do
      it { is_expected.to belong_to(:product) }
    end
  end
end
