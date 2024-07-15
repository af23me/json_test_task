# frozen_string_literal: true

module ExportParser 
  class UsersService < BaseService

    VALIDATE_KEYS = %i{
      id
      first_name
      last_name
      email
      company_id
      email_status
      active_status
      tokens
    }

    def collection
      return @collection if defined?(@collection)
      result = file_to_object!

      @collection = result.select { |i| valid?(i) && active?(i) }
                          .sort_by { |i| [i[:last_name], i[:first_name]] }
    end

    def active?(user)
      unless user[:active_status] == true
        App.logger.info(
          "[SKIP] User not active: #{user}\n"
        )
        return false
      end

      true
    end
  end
end
