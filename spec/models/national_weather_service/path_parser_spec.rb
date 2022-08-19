# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NationalWeatherService::PathParser, type: :model do
  it 'cannot be called with .new' do
    expect { described_class.new('/', nil) }.to raise_error(
      NoMethodError,
      /private method/
    )
  end

  describe '.parse' do
    subject(:parser) { described_class.parse(path, **kwargs) }

    context 'with a path without any placeholders' do
      let(:path) { '/alerts/active/count' }
      let(:kwargs) { {} }

      it 'parses correctly' do
        expect(parser).to eq(path)
      end
    end

    context 'with a path with segment placeholders' do
      let(:path) { '/icons/{set}/{timeOfDay}/{first}/{second}' }
      let(:kwargs) do
        {
          set: 'set_value',
          timeOfDay: 'time_of_day_value',
          first: 'first_value',
          second: 'second_value'
        }
      end

      it 'parses correctly' do
        expect(parser).to eq('/icons/set_value/time_of_day_value/first_value/second_value')
      end
    end

    context 'with a path with separated segment placeholders' do
      let(:path) { '/offices/{officeId}/headlines/{headlineId}' }
      let(:kwargs) do
        {
          officeId: '123houston',
          headlineId: 4
        }
      end

      it 'parses correctly' do
        expect(parser).to eq('/offices/123houston/headlines/4')
      end
    end

    context 'when comma-separated placeholder paths' do
      let(:path) { '/gridpoints/{wfo}/{x},{y}/forecast' }
      let(:kwargs) do
        {
          wfo: 'wfo_value',
          x: 41.343,
          y: '100'
        }
      end

      it 'parses correctly' do
        expect(parser).to eq('/gridpoints/wfo_value/41.343,100/forecast')
      end
    end
  end
end
