# frozen_string_literal: true

# Feedback
class Feedback
  attr_reader :subject, :likes, :dislikes, :nudge

  def initialize(**args)
    @subject = args[:subject] || 'default'
    @likes = 0
    @dislikes = 0
    @nudge = nil
  end

  def like
    @likes += 1
  end

  def dislike
    @dislikes += 1
  end

  def nudge!(data)
    @nudge = data
  end

  def nudged?
    @nudge
  end
end
