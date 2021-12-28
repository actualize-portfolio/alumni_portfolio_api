# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'relationships' do
    subject { build(:resource) }

    it { is_expected.to have_many(:locations).dependent(:destroy) }
    it { is_expected.to have_many(:addresses).through(:locations) }
    it { is_expected.to have_many(:phones).through(:locations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:desc) }
  end
end
