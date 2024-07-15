# frozen_string_literal: true

class EmailWorker < BaseWorker
  attr_accessor :from, :to, :message, :subject

  def send
    # fake sending
    App.logger.info(
      "Email sent: from #{from}; to #{to}; subject - #{subject}; Message: #{message}"
    )
  end
end
