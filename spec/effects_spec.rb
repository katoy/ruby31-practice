# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/effects'

RSpec.describe Effects do
  describe 'reverse' do
    it { expect(Effects.reverse.call('Ruby is fun!')).to eq 'ybuR si !nuf' }
    it { expect(Effects.reverse.call('')).to eq '' }
    it do
      expect do
        Effects.reverse.call(nil)
      end.to raise_error(ArgumentError, 'given nil')
    end
  end

  describe 'echo' do
    it do
      expect do
        Effects.echo(-1).call('Ruby is fun!')
      end.to raise_error(ArgumentError, 'negative argument')
    end
    it { expect(Effects.echo(0).call('Ruby is fun!')).to eq '  ' }
    it { expect(Effects.echo(2).call('Ruby is fun!')).to eq 'RRuubbyy iiss ffuunn!!' }
    it { expect(Effects.echo(3).call('Ruby is fun!')).to eq 'RRRuuubbbyyy iiisss fffuuunnn!!!' }
    it { expect(Effects.echo(0).call('')).to eq '' }
    it do
      expect do
        Effects.echo(2).call(nil)
      end.to raise_error(ArgumentError, 'given nil')
    end
  end

  describe 'loud' do
    it do
      expect do
        Effects.loud(-1).call('Ruby is fun!')
      end.to raise_error(ArgumentError, 'negative argument')
    end
    it { expect(Effects.loud(0).call('Ruby is fun!')).to eq 'RUBY IS FUN!' }
    it { expect(Effects.loud(2).call('Ruby is fun!')).to eq 'RUBY!! IS!! FUN!!!' }
    it { expect(Effects.loud(3).call('')).to eq '' }
    it do
      expect do
        Effects.loud(2).call(nil)
      end.to raise_error(ArgumentError, 'given nil')
    end
  end
end
