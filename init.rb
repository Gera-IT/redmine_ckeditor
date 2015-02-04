require 'redmine_redactor_js'


Redmine::Plugin.register :redmine_redactor_js_editor do
  name 'Redmine Redactor Js Editor plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  wiki_format_provider 'Imperavi Redactor', RedmineRedactor::WikiFormatting::Formatter,
                       RedmineRedactor::WikiFormatting::Helper
end



class FilesHook < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    javascript_include_tag('redactor.js', :plugin => 'redmine_redactor_js_editor') +
        stylesheet_link_tag('redactor.css', :plugin => 'redmine_redactor_js_editor')
  end
end


