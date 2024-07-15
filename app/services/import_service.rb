# frozen_string_literal: true

class ImportService < BaseService
  include ObjectProcess
  attr_accessor :timestamp

  def run
    File.open(import_file_path, 'w') do |file|
      grouped_users.sort.each do |data|
        company = companies.detect { |i| i[:id] == data[0] }
        safe_process_object(company) do
          users_emailed, users_not_emailed = prepare_users_email_data(company, data[1])
          file.puts(
            TemplateService.new(
              data: TemplateData::CompanyService.new(company:, users_emailed:, users_not_emailed:).run,
              template: IMPORT_TEMPLATE.dup
            ).output
          )
        end
      end
    end

    App.logger.info("File: #{import_file_path} saved")

    send_emails
    true
  rescue StandardError => e
    App.logger.error("Failed to process import: #{e}")
    false
  end

  private

  def grouped_users
    return @grouped_users if defined?(@grouped_users)

    result = {}
    users = ExportParser::UsersService.new(file_path: export_file_path('users')).collection
    users.each do |user|
      safe_process_object(user) do
        company_id = user[:company_id]
        result[company_id] ||= []
        result[company_id] << user
      end
    end

    @grouped_users = result
  end

  def companies
    @companies ||= ExportParser::CompaniesService.new(
      file_path: export_file_path('companies')
    ).collection
  end

  def export_file_path(file_name)
    "./#{ENV['EXPORT_ROOT_PATH']}/exports/#{timestamp}/#{file_name}.json"
  end

  def import_file_path
    "./tmp/#{ENV['RACK_ENV']}/imports/output_#{timestamp}.txt"
  end

  def prepare_users_email_data(company, users)
    users_emailed = []
    users_not_emailed = []
    users.each do |user|
      safe_process_object(user) do
        if (company[:email_status] == true && user[:email_status] == true)
          users_emailed << user
        else
          users_not_emailed << user
        end
      end
    end

    users_to_send.push(*users_emailed)

    return users_emailed, users_not_emailed
  end

  def users_to_send
    @users_to_send ||= []
  end

  # async send to queue
  def send_emails
    users_to_send.each do |user|
      EmailWorker.new(
        from: user[:email],
        to: 'test@email.com',
        subject: 'Test email subjetc',
        message: 'Test email message'
      ).send
    end
  end
end
