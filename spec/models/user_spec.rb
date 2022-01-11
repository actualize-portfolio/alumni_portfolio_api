# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:user_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:user_books) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_numericality_of(:age).only_integer }
  end

  describe 'avatar' do
    subject { create(:user, :with_avatar).avatar }

    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
  end
end
