# frozen_string_literal: true

module ExportParser 
  class BaseService < ::BaseService
    attr_accessor :file_path

    def collection
      raise "Not implemented"
    end

    def file_to_object!
      file = File.read(file_path)
      JSON.parse(file, symbolize_names: true)
    rescue => e
      raise "Failed to parse file #{file_path} with error: #{e}"
    end

    def valid?(item)
      missing_fields = []
      self.class::VALIDATE_KEYS.each do |field|
        if item[field].nil? || item[field] == ""
          missing_fields << field
        end
      end
      
      if missing_fields.any?
        App.logger.error(
          "[VALIDATION] Missing fields: #{missing_fields.join(',')} for item: #{item}\n"
        )
        return false
      end
  
      true
    end
  end
end
