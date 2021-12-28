# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'relationships' do
    subject { build(:address) }

    it { is_expected.to have_many(:locations).dependent(:destroy) }
    it { is_expected.to have_many(:resources).through(:locations) }
    it { is_expected.to have_many(:phones).through(:locations) }
  end

  describe 'validations' do
    subject { build(:address) }

    it { is_expected.to validate_presence_of(:street1) }
    it { is_expected.not_to validate_presence_of(:street2) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_numericality_of(:latitude) }
    it { is_expected.to validate_numericality_of(:longitude) }

    %w[XX ILL il].each do |invalid_code|
      it 'validates the state code' do
        expect(build(:address, state: invalid_code)).to be_invalid
      end
    end
  end

  describe '#geocode' do
    let(:address) { build(:address, :without_coordinates) }

    it 'can geocode itself based on full_address (latitude)' do
      expect { address.geocode }.to change(address, :latitude).from(nil).to(41.956837)
    end

    it 'can geocode itself based on full_address (longitude)' do
      expect { address.geocode }.to change(address, :longitude).from(nil).to(-87.688713)
    end
  end

  describe '#full_address' do
    let(:expected) { '121 N Lasalle, Chicago, IL, 60602' }

    it 'returns the full address as a single string' do
      expect(build(:address).full_address).to eq(expected)
    end
  end

  describe '#coordinates?' do
    context 'when latitude and longitude are set' do
      it 'returns true' do
        expect(build(:address).coordinates?).to eq(true)
      end
    end

    context 'when only latitude is set' do
      it 'returns false' do
        expect(build(:address, longitude: nil).coordinates?).to eq(false)
      end
    end

    context 'when only longitude is set' do
      it 'returns false' do
        expect(build(:address, latitude: nil).coordinates?).to eq(false)
      end
    end

    context 'when neither latitude or longitude are set' do
      it 'returns false' do
        expect(build(:address, :without_coordinates).coordinates?).to eq(false)
      end
    end
  end
end
