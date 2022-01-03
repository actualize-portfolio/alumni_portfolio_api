# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'relationships' do
    subject { build(:address) }

    it { is_expected.to have_many(:locations).dependent(:destroy) }
    it { is_expected.to have_many(:service_web_resources).through(:locations) }
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

  describe '#geocode_and_save!' do
    context 'when address can be geocoded' do
      let(:address) { create(:address, :without_coordinates) }

      it 'can geocode itself based on geocode_address (latitude)' do
        expect { address.geocode_and_save! }.to change(address, :latitude).from(nil).to(41.956837)
      end

      it 'can geocode itself based on geocode_address (longitude)' do
        expect { address.geocode_and_save! }.to change(address, :longitude).from(nil).to(-87.688713)
      end
    end

    context 'when address cannot be geocoded' do
      let(:address) do
        create(:address,
               :without_coordinates,
               street1: '4000 N Western Suite 3')
      end

      it 'raises an error' do
        expect { address.geocode_and_save! }.to(
          raise_error(Address::GeocodingError, 'Address could not be geocoded')
        )
      end
    end
  end

  describe '#geocode_address' do
    let(:expected) { '121 N Lasalle, Chicago, IL, 60602' }

    it 'returns the full address as a single string' do
      expect(build(:address).geocode_address).to eq(expected)
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
