module ObjectProcess
  def safe_process_object(object, &block)
    begin
      yield
    rescue => e
      App.logger.error("[SKIP] Failed to process object: #{object}; Error: #{e}")
    end
  end
end