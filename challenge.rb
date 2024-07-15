# frozen_string_literal: true

require './config/initialize'

timestamp = ARGV.first

ChallengeService.new(timestamp:).run
