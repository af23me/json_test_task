# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'dotenv'
require 'json'

require 'byebug' if %w(test development).include?(ENV['RACK_ENV'])

Dir[("#{__dir__}/initializers/**/*.rb")].each { |f| require f }
Dir[("#{__dir__}/../app/**/*.rb")].each { |f| require f }
