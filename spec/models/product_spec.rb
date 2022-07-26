# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:prod) { build(:product) }

  describe 'validations' do
    describe '#name' do
      it { is_expected.not_to allow_value('').for(:name) }
      it { is_expected.to allow_value('testproduct').for(:name) }
    end

    describe '#description' do
      it { is_expected.not_to allow_value('').for(:description) }
      it { is_expected.to allow_value('testproduct').for(:description) }
    end

    describe '#quantity' do
      it { is_expected.not_to allow_value('').for(:quantity) }
      it { is_expected.to allow_value('testquantity').for(:quantity) }
    end

    describe '#price' do
      it { is_expected.not_to allow_value('').for(:price) }
      it { is_expected.to allow_value('testprice').for(:price) }
    end
  end

  describe 'associations' do
    describe 'when product belongs to a user' do
      it { is_expected.to belong_to(:user) }
    end

    describe 'when product has many imagess' do
      it { is_expected.to have_many_attached(:images) }
    end

    describe 'when product has many comments' do
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end

    describe 'when product has many line_items' do
      it { is_expected.to have_many(:line_items).dependent(:destroy) }
    end
  end

  describe 'Upload images' do
    it 'saves the image' do
      file = Rails.root.join('app/assets/images/ava.png')
      image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'ava.png').signed_id
      prod = described_class.new(images: image)
      prod.send(:images_type)
      expect(prod.errors.messages).to eq({})
    end

    it 'does not save the image' do
      file = Rails.root.join('app/assets/images/web-application-development.pdf')
      image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'),
                                                       filename: 'web-application-development.pdf').signed_id
      prod = described_class.new(images: image)
      prod.send(:images_type)
      expect(prod.errors.messages).not_to be(nil)
    end
  end
end
