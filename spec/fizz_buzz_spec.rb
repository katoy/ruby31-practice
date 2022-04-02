# frozen_string_literal: true

require './spec/spec_helper'
require './lib/fizz_buzz'

RSpec.describe 'Fizz Buzz' do
  context 'test' do
    it 'returns valid string' do
      expect(fizz_buzz(1)).to eq '1'
      expect(fizz_buzz(2)).to eq '2'
      expect(fizz_buzz(3)).to eq 'Fizz'
      expect(fizz_buzz(4)).to eq '4'
      expect(fizz_buzz(5)).to eq 'Buzz'
      expect(fizz_buzz(6)).to eq 'Fizz'
      expect(fizz_buzz(15)).to eq 'Fizz Buzz'
    end

    it do
      expect(fizz_buzz(0)).to eq 'Fizz Buzz'
    end

    it do
      expect do
        fizz_buzz('X')
      end.to raise_error(NoMethodError, /zero\?/)
    end
  end

  context 'test2' do
    it 'returns valid string' do
      expect(fizz_buzz2(1)).to eq '1'
      expect(fizz_buzz2(2)).to eq '2'
      expect(fizz_buzz2(3)).to eq 'Fizz'
      expect(fizz_buzz2(4)).to eq '4'
      expect(fizz_buzz2(5)).to eq 'Buzz'
      expect(fizz_buzz2(6)).to eq 'Fizz'
      expect(fizz_buzz2(15)).to eq 'Fizz Buzz'

      expect(fizz_buzz2(0)).to eq '0'
      expect(fizz_buzz2('X')).to eq 'X'
    end
  end
end
