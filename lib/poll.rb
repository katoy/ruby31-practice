# frozen_string_literal: true

require_relative './feedback'
require_relative './participant'

# Poll
class Poll
  attr_reader :error_count

  def initialize(**args)
    @feedbacks = args[:subjects].map { |subject| Feedback.new(subject:) }
    @participants = args[:names].map { |name| Participant.new(name:) }
    @error_count = 0
    @nudge_template = nil
  end

  def run
    @feedbacks.sample.nudge!(nudge_template)
    @feedbacks.each do |feedback|
      @participants.each do |participant|
        @error_count += 1 unless participant.evaluate(feedback)
      end
    end
    nudge_template
  end

  def vote_count
    @feedbacks.inject(0) do |memo, feedback|
      memo += (feedback.likes + feedback.dislikes)
    end
  end

  def ranking
    @feedbacks.sort { |a, b| b.likes <=> a.likes }
  end

  private

  def nudge_template
    @nudge_template ||= "nudge template #{rand(1..10)}"
  end
end
