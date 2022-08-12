# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/log_formatter'

require 'net/http'
require 'uri'
require 'json'

RSpec.describe LogFormatter do
  describe 'self.format_log' do
    context 'log-data from url' do
      let(:url) { 'https://samples.jnito.com/access-log.json' }
      let(:json_data) do
        log_data = Net::HTTP.get(URI.parse(url))
        JSON.parse(log_data, symbolize_names: true)
      end

      it do
        text = LogFormatter.format_log(json_data)
        lines = text.lines(chomp: true)
        expect(lines[0]).to eq '[OK] request_id=1, path=/products/1'
        expect(lines[1]).to eq '[ERROR] request_id=2, path=/wp-login.php, status=404, error=Not found'
        expect(lines[2]).to eq '[WARN] request_id=3, path=/products, duration=1023.8'
        expect(lines[3]).to eq '[ERROR] request_id=4, path=/dangerous, status=500, error=Internal server error'
      end
    end

    context 'from json' do
      let(:json_data) do
        [
          {
            "request_id": '1',
            "path": '/products/1',
            "status": 200,
            "duration": 651.7
          },
          {
            "request_id": '2',
            "path": '/products',
            "status": 200,
            "duration": 1023.8
          },
          {
            "request_id": '3',
            "path": '/wp-login.php',
            "status": 404,
            "duration": 48.1,
            "error": 'Not found'
          },
          {
            "request_id": '4',
            "path": '/dangerous',
            "status": 500,
            "duration": 43.6,
            "error": 'Internal server error'
          }
        ]
      end

      it do
        text = LogFormatter.format_log(json_data)
        lines = text.lines(chomp: true)
        expect(lines[0]).to eq '[OK] request_id=1, path=/products/1'
        expect(lines[1]).to eq '[WARN] request_id=2, path=/products, duration=1023.8'
        expect(lines[2]).to eq '[ERROR] request_id=3, path=/wp-login.php, status=404, error=Not found'
        expect(lines[3]).to eq '[ERROR] request_id=4, path=/dangerous, status=500, error=Internal server error'
      end
    end

    context 'duration' do
      let(:json_data) do
        [
          {
            "request_id": '1',
            "path": '/products/1',
            "status": 200,
            "duration": 999.9
          },
          {
            "request_id": '2',
            "path": '/products/2',
            "status": 200,
            "duration": 1000
          }
        ]
      end

      it 'duration < 1000 なら OK, そうでなければ WARN' do
        text = LogFormatter.format_log(json_data)
        lines = text.lines(chomp: true)
        expect(lines[0]).to eq '[OK] request_id=1, path=/products/1'
        expect(lines[1]).to eq '[WARN] request_id=2, path=/products/2, duration=1000'
      end
    end

    context 'enpty log' do
      let(:json_data) { {} }

      it do
        text = LogFormatter.format_log(json_data)
        lines = text.lines(chomp: true)
        expect(lines).to eq []
      end
    end

    context 'unknon log' do
      let(:json_data) do
        [
          {
            "request_id_x": '1',
            "path_x": '/products/1'
          },
          {
            "request_id": '2',
            "path_x": '/products/2'
          },
          {
            "request_id_x": '3',
            "path": '/products/3'
          }
        ]
      end

      let(:expect_lines) do
        [
          '[???] {:request_id_x=>"1", :path_x=>"/products/1"}',
          '[???] {:request_id=>"2", :path_x=>"/products/2"}',
          '[???] {:request_id_x=>"3", :path=>"/products/3"}'
        ]
      end

      it do
        text = LogFormatter.format_log(json_data)
        lines = text.lines(chomp: true)
        expect(lines).to eq expect_lines
      end
    end
  end
end
