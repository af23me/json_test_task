# frozen_string_literal: true

module ExportParser 
  class CompaniesService < BaseService

    VALIDATE_KEYS = %i{
      id
      name
      top_up
      email_status
    }

    def collection
      return @collection if defined?(@collection)
      result = file_to_object!

      @collection = result.select { |i| valid?(i) }
    end
  end
end
