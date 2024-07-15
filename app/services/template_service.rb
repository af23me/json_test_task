# frozen_string_literal: true

class TemplateService < BaseService
  attr_accessor :data, :template

  def output
    return @output if defined?(@output)

    result = template
    data.each { |k,v| result.gsub!("%#{k}%", v.to_s) }
    @output = result
  end
end
