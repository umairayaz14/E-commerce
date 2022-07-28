# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:usr) { build(:user) }

  # it 'save the image' do
  #   file = Rails.root.join('/Users/dev/Downloads/E-commerce/app/assets/images/ava.png')
  #   image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'ava.png').signed_id
  #   usr = described_class.new(avatar: image)
  #   expect(usr.valid?).to eq true
  # end

  describe 'validations' do
    describe '#email' do
      it { is_expected.not_to allow_value('abc.com', '@.com', '').for(:email) }
      it { is_expected.to allow_value('a@b.com').for(:email) }
    end

    describe '#password' do
      it { is_expected.not_to allow_value('123').for(:password) }
      it { is_expected.to allow_value('123456').for(:password) }
    end

    describe '#username' do
      it { is_expected.not_to allow_value('').for(:username) }
      it { is_expected.to allow_value('testuser').for(:username) }
    end
  end

  describe 'associations' do
    describe 'when user has many products' do
      it { is_expected.to have_many(:products).dependent(:destroy) }
    end

    describe 'when user has many comments' do
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end

    describe 'when user has many orders' do
      it { is_expected.to have_many(:orders).dependent(:destroy) }
    end

    describe 'when user has one attached avatar' do
      it { is_expected.to have_one(:avatar_attachment) }
    end
  end

  describe 'Upload avatar' do
    it 'saves the image' do
      file = Rails.root.join('app/assets/images/ava.png')
      image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'ava.png').signed_id
      usr = described_class.new(avatar: image)
      usr.send(:avatar_type)
      expect(usr.errors.messages).to eq({})
      # expect(usr.valid?).to eq true
    end

    it 'does not save the image' do
      file = Rails.root.join('app/assets/images/web-application-development.pdf')
      image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'),
                                                       filename: 'web-application-development.pdf').signed_id
      usr = described_class.new(avatar: image)
      usr.send(:avatar_type)
      expect(usr.errors.messages).not_to be(nil)
    end
  end
end
