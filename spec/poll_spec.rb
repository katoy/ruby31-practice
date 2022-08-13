# frozen_string_literal: true

# See https://www.netguru.com/blog/ruby-tests-rspec-mocks
#     How to Improve Ruby Tests Using RSpec Mocks

require_relative 'spec_helper'
require_relative '../lib/poll'

RSpec.describe Poll do
  let(:names) { %w[alice adam peter kate] }
  let(:subjects) { %w[math physics history biology] }
  subject { described_class.new(names:, subjects:) }

  describe 'test a class has been instantiated' do
    context 'instances do NOT receive messages' do
      context 'when 2 participant and 4 subjects' do
        let(:names) { %w[alice adam] }

        it 'instantiates 2 participants' do
          expect(Participant).to receive(:new).with(hash_including(name: 'adam')).once
          expect(Participant).to receive(:new).with(hash_including(name: 'alice')).once
          subject
        end
      end
    end

    context 'instances receive messages' do
      context 'when 2 participant and 4 subjects' do
        let(:names) { %w[alice adam] }

        it 'instantiates 2 participants' do
          expect(Participant).to receive(:new).with(hash_including(name: 'adam'))
                                              .and_call_original.once
          expect(Participant).to receive(:new).with(hash_including(name: 'alice'))
                                              .and_call_original.once
          subject.run
        end
      end
    end
  end

  describe 'test instances of a class' do
    context 'single instances' do
      context 'when 1 participant and 4 subjects' do
        let(:names) { %w[alice] }

        it 'asks participant for evaluation 4 times' do
          expect_any_instance_of(Participant).to receive(:evaluate)
            .with(instance_of(Feedback)).exactly(4).times
          subject.run
        end
      end
    end

    context 'multiple instances' do
      context 'when 4 participants and 4 subjects' do
        it 'asks participants for evaluation 16 times' do
          fake_participant = instance_double(Participant)
          allow(fake_participant).to receive(:evaluate)
          allow(Participant).to receive(:new).and_return(fake_participant)

          expect(fake_participant).to receive(:evaluate)
            .with(instance_of(Feedback)).exactly(16).times
          subject.run
        end
      end
    end
  end

  describe 'induce error in one of the instances' do
    context 'when 1 participant fails to evaluate 1 subject' do
      context 'when 4 participants and 4 subjects' do
        it 'produces 1 error' do
          allow_any_instance_of(Participant).to receive(:evaluate)
            .and_wrap_original do |evaluate_method, feedback|
            is_adam = evaluate_method.receiver.name == 'adam'
            is_math = feedback.subject == 'math'
            is_adam && is_math ? false : evaluate_method.call(feedback)
          end
          expect { subject.run }.to change { subject.error_count }.from(0).to(1)
                                .and change { subject.vote_count }.from(0).to(15)
        end
      end
    end
  end

  describe 'test instances with expected arguments not known in advance' do
    context 'using spy' do
      context 'when 4 participants and 4 subjects' do
        it 'nudges one feedback' do
          fake_feedback = instance_spy(Feedback)
          allow(Feedback).to receive(:new).and_return(fake_feedback)
          nudge_template = subject.run
          expect(fake_feedback).to have_received(:nudge!).with(nudge_template).once
        end
      end
    end

    context 'using double' do
      context 'when 4 participants and 4 subjects' do
        it 'nudges one feedback' do
          fake_feedback = instance_double(Feedback)
          allow(fake_feedback).to receive(:nudge!)
          allow(fake_feedback).to receive(:nudged?)
          allow(fake_feedback).to receive(:like)
          allow(fake_feedback).to receive(:dislike)
          allow(Feedback).to receive(:new).and_return(fake_feedback)
          nudge_template = subject.run
          expect(fake_feedback).to have_received(:nudge!).with(nudge_template).once
        end
      end
    end
  end
end
