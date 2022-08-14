# frozen_string_literal: true

require 'simplecov' # These two lines must go first
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'

require 'active_support/all'
require 'active_support/testing/time_helpers'
Time.zone = 'Asia/Tokyo'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
# $ export MINITEST_REPORTER=ProgressReporter
#
# Minitest::Reporters::DefaultReporter  # => Redgreen-capable version of standard Minitest reporter
# Minitest::Reporters::SpecReporter     # => Turn-like output that reads like a spec
# Minitest::Reporters::ProgressReporter # => Fuubar-like output with a progress bar
# Minitest::Reporters::RubyMateReporter # => Simple reporter designed for RubyMate
# Minitest::Reporters::RubyMineReporter # => Reporter designed for RubyMine IDE and TeamCity CI server
# Minitest::Reporters::JUnitReporter    # => JUnit test reporter designed for JetBrains TeamCity
# Minitest::Reporters::MeanTimeReporter # => Produces a report summary showing the slowest running tests
# Minitest::Reporters::HtmlReporter     # => Generates an HTML report of the t
