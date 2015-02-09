require_dependency 'application_helper'

module ApplicationHelper

  def format_activity_description_with_redactor(text)
    if RedmineRedactorJs.enabled?
      simple_format(truncate(strip_tags(text.to_s), :length => 120))
    else
      format_activity_description_without_redactor(text)
    end
  end
  alias_method_chain :format_activity_description, :redactor
end
