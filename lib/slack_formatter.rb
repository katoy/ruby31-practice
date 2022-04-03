# frozen_string_literal: true

# See
# https://shase428.hatenablog.jp/entry/2017/03/10/093131

require 'rspec'
require 'slack-notifier'

RSpec::Support.require_rspec_core 'formatters/base_formatter'

class SlackFormatter < RSpec::Core::Formatters::BaseFormatter
  RSpec::Core::Formatters.register self, :example_passed, :example_failed

  def initialize(output)
    super(output)
    @results = { stats: [], details: [] }
  end

  def example_passed(_notification)
    @results[:stats] << 'OK'
  end

  def example_failed(notification)
    @results[:stats] << 'NG'
    @results[:details] << notification.fully_formatted_lines(1)
  end

  def close(_notification)
    post_slack
  end

  def post_slack
    url = ENV['SLACK_WEBHOOK_URL']

    puts 'sending slack ...'
    notifier = Slack::Notifier.new(url)
    note =
      if @results[:stats].include?('NG')
        { text: "ダメー\n#{@results[:details]}", color: 'warning' }
      else
        { text: 'おっけー', color: 'good' }
      end
    notifier.post text: '', attachments: [note]
  end
end
