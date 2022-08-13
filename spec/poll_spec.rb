# frozen_string_literal: true

# See https://www.netguru.com/blog/ruby-tests-rspec-mocks
#     How to Improve Ruby Tests Using RSpec Mocks

require_relative 'spec_helper'
require_relative '../lib/poll'

RSpec.describe Poll do
  let(:instance) { described_class.new(names:, subjects:) }
  let(:names) { %w[alice adam peter kate] }
  let(:subjects) { %w[math physics history biology] }

  describe 'test a class has been instantiated' do
    context 'hwn new, instances do NOT receive messages' do
      context 'when 4 participant and 4 subjects' do
        it 'instantiates 4 participants' do
          expect(Participant).to receive(:new).with(hash_including(name: 'adam')).once
          expect(Participant).to receive(:new).with(hash_including(name: 'alice')).once
          expect(Participant).to receive(:new).with(hash_including(name: 'peter')).once
          expect(Participant).to receive(:new).with(hash_including(name: 'kate')).once
          instance
        end
      end
    end

    context 'when run, instances receive messages' do
      context 'when 4 participant and 4 subjects' do
        it 'instantiates 4 participants' do
          expect(Participant).to receive(:new).with(hash_including(name: 'adam'))
                                              .and_call_original.once
          expect(Participant).to receive(:new).with(hash_including(name: 'alice'))
                                              .and_call_original.once
          expect(Participant).to receive(:new).with(hash_including(name: 'peter'))
                                              .and_call_original.once
          expect(Participant).to receive(:new).with(hash_including(name: 'kate'))
                                              .and_call_original.once
          instance.run
        end
      end
    end
  end

  describe 'test instances of a class' do
    context 'single instances' do
      context 'when 1 participant and 4 subjects' do
        let(:names) { %w[alice] }

        before do
          expect_any_instance_of(Participant).to receive(:evaluate)
            .with(instance_of(Feedback)).exactly(4).times
        end

        it 'asks participant for evaluation 4 times' do
          instance.run
        end
      end
    end

    context 'multiple instances' do
      context 'when 4 participants and 4 subjects' do
        let(:fake_participant) { instance_double(Participant) }

        before do
          allow(fake_participant).to receive(:evaluate)
          allow(Participant).to receive(:new).and_return(fake_participant)
        end

        it 'asks participants for evaluation 16 times' do
          expect(fake_participant).to receive(:evaluate)
            .with(instance_of(Feedback)).exactly(16).times
          instance.run
        end
      end
    end
  end

  describe 'induce error in one of the instances' do
    context 'when 1 participant fails to evaluate 1 subject' do
      context 'when 4 participants and 4 subjects' do
        before do
          allow_any_instance_of(Participant).to receive(:evaluate)
            .and_wrap_original do |evaluate_method, feedback|
            is_adam = evaluate_method.receiver.name == 'adam'
            is_math = feedback.subject == 'math'
            is_adam && is_math ? false : evaluate_method.call(feedback)
          end
        end

        it 'produces 1 error' do
          expect do
            instance.run
          end
            .to change { instance.error_count }.from(0).to(1)
            .and change { instance.vote_count }.from(0).to(15)
        end
      end
    end
  end

  describe 'test instances with expected arguments not known in advance' do
    context 'using spy' do
      context 'when 4 participants and 4 subjects' do
        let(:fake_feedback) { instance_spy(Feedback) }

        before do
          allow(Feedback).to receive(:new).and_return(fake_feedback)
        end

        it 'nudges one feedback' do
          nudge_template = instance.run
          expect(fake_feedback).to have_received(:nudge!).with(nudge_template).once
        end
      end
    end

    context 'using double' do
      context 'when 4 participants and 4 subjects' do
        let(:fake_feedback) { instance_double(Feedback) }

        before do
          allow(fake_feedback).to receive(:nudge!)
          allow(fake_feedback).to receive(:nudged?)
          allow(fake_feedback).to receive(:like)
          allow(fake_feedback).to receive(:dislike)
          allow(Feedback).to receive(:new).and_return(fake_feedback)
        end

        it 'nudges one feedback' do
          nudge_template = instance.run
          expect(fake_feedback).to have_received(:nudge!).with(nudge_template).once
        end
      end
    end
  end
end
