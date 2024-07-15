# frozen_string_literal: true

module TemplateData
  class UserService < BaseService
    attr_accessor :user, :company

    def run
      data = user.slice(:first_name, :last_name, :email)
      data[:previous_tokens_size] = user[:tokens]
      data[:new_tokens_size] = (user[:tokens] + company[:top_up])
      data
    end

  end
end
