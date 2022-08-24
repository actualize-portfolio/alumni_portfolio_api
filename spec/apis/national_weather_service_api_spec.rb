# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NationalWeatherServiceApi, vcr: true do
  subject(:nws_api) { described_class.new }

  let(:stubs)  { Faraday::Adapter::Test::Stubs.new(strict_mode: true) }
  let(:conn)   { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:client) { Client.new(conn) }

  describe 'metaprogrammed methods' do
    let(:mock_faraday_client) { instance_double(Faraday) }

    it '#alerts_query' do

    end

    it '#alerts_active' do
      expect(nws_api.alerts_active).to be_a_kind_of(Hash)
    end

    it '#alerts_active_count' do
      expect(nws_api.alerts_active_count).to be_a_kind_of(Hash)
    end

    it '#alerts_active_area' do
      expect(nws_api.alerts_active_area(area: 'ad')).to be_a_kind_of(Hash)
    end

    it '#alerts_active_region' do
      stubs.get('/alerts/active/region/AL') do
        [
          200,
          { 'Content-Type': 'application/javascript' },
        ]
      end

      # uncomment to raise Stubs::NotFound
      # expect(client.httpbingo('api', params: { abc: 123, foo: 'Kappa' })).to eq('127.0.0.1')
      nws_api.alerts_active_region(region: 'AL')
      # expect(client.httpbingo('api', params: { abc: 123 })).to eq('127.0.0.1')
      stubs.verify_stubbed_calls
    end

    it '#alerts_types' do
      expect(nws_api.alerts_types).to be_a_kind_of(Hash)
    end

    it '#alerts_single' do
      expect(nws_api.alerts_single(id: 12)).to be_a_kind_of(Hash)
    end

    it '#glossary' do
      expect(nws_api.glossary).to be_a_kind_of(Hash)
    end
  end
end

[ :glossary, :gridpoint, :gridpoint_forecast, :gridpoint_forecast_hourly, :gridpoint_stations, :icons, :iconsDualCondition, :icons_summary, :satellite_thumbnails, :station_observation_list, :station_observation_latest, :station_observation_time, :obs_stations, :obs_station, :office, :office_headline, :office_headlines, :point_stations, :radar_servers, :radar_server, :radar_stations, :radar_station, :radar_station_alarms, :radar_queue, :radar_profiler, :products_query, :product_locations, :product_types, :products_type, :products_type_locations, :location_products, :products_type_location, :zone_list, :zone_list_type, :zone_forecast, :zone_obs, :zone_stations, :alerts_query, :point, :product, :zone]
