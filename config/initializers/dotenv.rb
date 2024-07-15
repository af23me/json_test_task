# frozen_string_literal: true

Dotenv.load(
  ".env.#{ENV.fetch('RACK_ENV')}.local",
  '.env.local',
  ".env.#{ENV.fetch('RACK_ENV')}",
  '.env'
)
