# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/ticket'
require_relative '../lib/gate'

RSpec.describe Ticket do
  let(:ticket) { Ticket.new(200) }
  let(:umeda) { Gate.find(:umeda) }
  let(:juso) { Gate.find(:juso) }
  let(:time_one) { Time.zone.parse('2022-01-01 00:01:02') }
  let(:time_two) { Time.zone.parse('2022-01-01 00:02:03') }

  describe 'initializer' do
    it 'Error when fair < 0' do
      expect do
        Ticket.new(-1)
      end.to raise_error(ArgumentError, /fare is negative/)
    end

    it 'OK if fair > 0' do
      t = Ticket.new(1)
      expect(t.nil?).to eq false
    end
  end

  describe 'unused?, using?, used?' do
    context 'before enter' do
      it do
        expect(ticket.unused?).to eq true
        expect(ticket.using?).to eq false
        expect(ticket.used?).to eq false
      end
    end

    context 'after enter' do
      before { umeda.enter(ticket) }

      it do
        expect(ticket.unused?).to eq false
        expect(ticket.using?).to eq true
        expect(ticket.used?).to eq false
      end
    end

    context 'after exit' do
      before do
        travel_to(time_one) { umeda.enter(ticket) }
        travel_to(time_two) do
          debuger
          juso.exit(ticket)
        end
      end

      it do
        expect(ticket.unused?).to eq false
        expect(ticket.using?).to eq false
        expect(ticket.used?).to eq true
      end
    end
  end

  describe 'stamp(name), entered_at, stampeds' do
    context 'some times' do
      it do
        travel_to(time_one) { ticket.stamp('umeda') }
        expect(ticket.entered_st).to eq({ name: :umeda, time: time_one })
        expect(ticket.stampeds).to eq [{ name: :umeda, time: time_one }]

        travel_to(time_two) { ticket.stamp(:juso) }
        expect(ticket.entered_st).to eq({ name: :umeda, time: time_one })
        expect(ticket.stampeds).to eq(
          [
            { name: :umeda, time: time_one },
            { name: :juso, time: time_two }
          ]
        )
      end
    end
  end
end
