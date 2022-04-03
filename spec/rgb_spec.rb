# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/rgb'

RSpec.describe 'RGB' do
  describe '#to_hex' do
    it 'returns valid string' do
      expect(to_hex(0, 0, 0)).to eq '#000000'
      expect(to_hex(255, 255, 255)).to eq '#ffffff'
      expect(to_hex(4, 60, 120)).to eq '#043c78'

      expect(to_hex(256, 1, 2)).to eq '#1000102' # TODO: エラーになるべき
    end
  end

  describe '#to_ints' do
    it 'returns valid array' do
      expect(to_ints('#000000')).to eq [0, 0, 0]
      expect(to_ints('#ffffff')).to eq [255, 255, 255]
      expect(to_ints('#043c78')).to eq [4, 60, 120]

      expect(to_ints('#FFFFFF')).to eq [255, 255, 255]
      expect(to_ints('#043C78')).to eq [4, 60, 120]

      expect(to_ints('#G00102')).to eq [0, 1, 2] # TODO: エラーになるべき
    end
  end

  describe '#to_hex2' do
    it 'returns valid string' do
      expect(to_hex2(0, 0, 0)).to eq '#000000'
      expect(to_hex2(255, 255, 255)).to eq '#ffffff'
      expect(to_hex2(4, 60, 120)).to eq '#043c78'

      expect do
        to_hex2(256, 1, 2)
      end.to raise_error(ArgumentError, /Out of range/)
    end
  end

  describe '#to_ints' do
    it 'returns valid array' do
      expect(to_ints2('#000000')).to eq [0, 0, 0]
      expect(to_ints2('#ffffff')).to eq [255, 255, 255]
      expect(to_ints2('#043c78')).to eq [4, 60, 120]

      expect(to_ints2('#FFFFFF')).to eq [255, 255, 255]
      expect(to_ints2('#043C78')).to eq [4, 60, 120]

      expect do
        to_ints2('#G00102')
      end.to raise_error(ArgumentError, /Invalid format/)

      expect do
        to_ints2('#FFF')
      end.to raise_error(ArgumentError, /Invalid format/)
    end
  end
end
