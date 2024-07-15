# frozen_string_literal: true

require 'logger'

class App
  def self.logger
    return @logger if defined?(@logger)

    log_location = (ENV['RACK_ENV'] == 'test') ? "./log/test.txt" : $stdout

    @logger = Logger.new(log_location)
    @logger.level = ENV.fetch('LOG_LEVEL', Logger::INFO)
    @logger
  end
end
