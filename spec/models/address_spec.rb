# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    subject { build(:address) }

    it { is_expected.to validate_presence_of(:street1) }
    it { is_expected.not_to validate_presence_of(:street2) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_numericality_of(:latitude) }
    it { is_expected.to validate_numericality_of(:longitude) }

    it 'validates the state code' do
      expect(build(:address, state: 'XX')).to be_invalid
      expect(build(:address, state: 'ILL')).to be_invalid
      expect(build(:address, state: 'il')).to be_invalid
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
    let(:expected) { '121 N Lasalle, Suite 2, Chicago, IL, 60602' }

    it 'returns the full address as a single string' do
      expect(build(:address).full_address).to eq(expected)
    end
  end

  describe '#geocoded?' do
    context 'when latitude and longitude are set' do
      it 'returns true' do
        expect(build(:address).has_coordinates?).to eq(true)
      end
    end

    context 'when only latitude is set' do
      it 'returns false' do
        expect(build(:address, longitude: nil).has_coordinates?).to eq(false)
      end
    end

    context 'when only longitude is set' do
      it 'returns false' do
        expect(build(:address, latitude: nil).has_coordinates?).to eq(false)
      end
    end

    context 'when neither latitude or longitude are set' do
      it 'returns false' do
        expect(build(:address, :without_coordinates).has_coordinates?).to eq(false)
      end
    end
  end
end
