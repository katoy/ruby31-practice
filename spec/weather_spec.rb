# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/gate'
require_relative '../lib/weather'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

RSpec.describe Weather do
  describe 'self.weather' do
    subject(:ret) { Weather.weather('130000') }

    context '妥当なcode' do
      let(:expect_json) do
        [
          {
            name: '東京地方',
            info: {
              time: '20220812 17:00:00', code: '200',
              weather: 'くもり　所により　雨　で　雷を伴う',
              wind: '南の風　やや強く',
              wave: '１．５メートル',
              temp_min: '23.6', temp_max: '31.4'
            }
          },
          {
            name: '東京地方',
            info: {
              time: '20220813 00:00:00', code: '302',
              weather: '雨　朝　まで　時々　くもり　所により　夕方　から　雷を伴い　激しく　降る',
              wind: '南の風　後　やや強く　海上　では　後　南の風　非常に強く',
              wave: '１．５メートル　後　２．５メートル',
              temp_min: '23.6', temp_max: '31.4'
            }
          },
          {
            name: '東京地方',
            info: {
              time: '20220814 00:00:00', code: '200',
              weather: 'くもり', wind: '南西の風　やや強く　後　南の風',
              wave: '１．５メートル　後　０．５メートル',
              temp_min: '23.6', temp_max: '31.4'
            }
          }
        ]
      end

      it '東京の情報', :vcr do
        expect(ret[0]).to eq expect_json
      end
    end

    context '不正なコード' do
      let(:expect_json) { {} }
      it '不正なcode' do
        expect(Weather.weather('999999')[:error]).to match(/404 Not Found/)
      end
    end
  end
end
