# frozen_string_literal: true

module TemplateData
  class CompanyService < BaseService
    include ObjectProcess
    attr_accessor :users_emailed, :users_not_emailed, :company

    def run
      {
        company_id: company[:id],
        company_name: company[:name],
        users_emailed: users_template(users_emailed),
        users_not_emailed: users_template(users_not_emailed),
        company_total_topups:
      }
    end

    private

    def company_total_topups
      (users_emailed.size + users_not_emailed.size) * company[:top_up]
    end

    def users_template(users = [])
      users.map do |user|
        TemplateService.new(
          data: TemplateData::UserService.new(company:, user:).run,
          template: IMPORT_USER_TEMPLATE.dup
        ).output
      end.join('')
    end
  end
end
