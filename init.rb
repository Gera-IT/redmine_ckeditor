require 'application_controller_patch'
require 'redactor_rails_document_uploader'
require 'redactor_rails_picture_uploader'

Redmine::Plugin.register :redmine_redactor_js_editor do
  name 'Redmine Redactor Js Editor plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  wiki_format_provider 'Imperavi Redactor', RedmineRedactor::WikiFormatting::Formatter,
                       RedmineRedactor::WikiFormatting::Helper


  Rails.configuration.to_prepare do
    # This tells the Redmine version's controller to include the module from the file above.
    ApplicationController.send(:include, DeviseCurrentUser::ApplicationControllerPatch)
  end
end



class FilesHook < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    javascript_include_tag('redactor.js', :plugin => 'redmine_redactor_js_editor') +
        stylesheet_link_tag('redactor.css', :plugin => 'redmine_redactor_js_editor') +
        javascript_include_tag('filemanager.js', :plugin => 'redmine_redactor_js_editor')+
        javascript_include_tag('imagemanager.js', :plugin => 'redmine_redactor_js_editor')
  end
end


