# frozen_string_literal: true

class ChallengeService < BaseService
  attr_accessor :timestamp

  def run
    App.logger.info("Start import for timestamp: #{timestamp}")
    import_service = ImportService.new(timestamp:)

    if import_service.run
      App.logger.info("Import for timestamp: #{timestamp} done")
    end
  end
end
