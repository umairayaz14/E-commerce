# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'validations' do
    describe '#name' do
      it { is_expected.not_to allow_value('').for(:name) }
      it { is_expected.to allow_value('testuser').for(:name) }
    end

    describe '#valid_til' do
      it { is_expected.not_to allow_value('').for(:valid_til) }
      it { is_expected.to allow_value('2022-07-22').for(:valid_til) }
    end

    describe '#value' do
      it { is_expected.not_to allow_value('').for(:value) }
      it { is_expected.to allow_value('2022-07-22').for(:value) }
    end
  end

  describe 'uniqueness of name' do
    it 'name filed is unique' do
      coup1 = create(:coupon, name: 'test')
      coup2 = build(:coupon, name: 'test')

      expect(coup2.save).to be_falsey
    end

    it 'name field is not unique' do
      coup1 = create(:coupon)
      coup2 = build(:coupon)
      expect(coup2.save).to be_truthy
    end
  end

  describe 'length of name field' do
    it 'length of name between 4 and 10 characters' do
      coup = build(:coupon, name: 'coupon')
      expect(coup.save).to be_truthy
    end

    it 'length of name less than 4 characters' do
      coup1 = build(:coupon, name: 'cou')
      expect(coup1.save).to be_falsey
    end

    it 'length of name greater than 10 characters' do
      coup1 = build(:coupon, name: 'coupontests')
      expect(coup1.save).to be_falsey
    end
  end
end
