module RedmineRedactor::WikiFormatting
  module Helper
    def replace_editor_tag(field_id)
      javascript_tag <<-EOT
      $(document).ready(function() {
        #{replace_editor_script(field_id)}
      });
      EOT
    end

    def set_config
    end

    def replace_editor_script(field_id)
      <<-EOT
      (function() {
        var id = '#{field_id}';
        var textarea = document.getElementById(id);
        if (!textarea) return;

    $('##{field_id}').redactor({
        focus: true,
        //linebreaks: true,
        //paragraphy: false,
        pastePlainText: true,
        imageUpload: '/pictures.json?key=#{user_api_key}',
        imageManagerJson: '/pictures.json?key=#{user_api_key}',
        fileUpload: '/documents.json?key=#{user_api_key}',
        fileManagerJson: '/documents.json?key=#{user_api_key}',
        plugins: ['filemanager', 'imagemanager', 'table', 'video', 'fullscreen', 'fontsize', 'fontfamily', 'fontcolor']
    });
      })();
      EOT
    end

    def overwrite_functions
    end

    def user_api_key
      return nil if User.current.type == "AnonymousUser"
      User.current.api_key
    end

    def redactor_javascripts
      javascript_include_tag("redactor.js", :plugin => "redmine_redactor_js_editor")
    end


    def initial_setup
    end

    def wikitoolbar_for(field_id)
      if params[:format] == "js"
        javascript_tag(replace_editor_script(field_id))
      else
        redactor_javascripts +
            stylesheet_link_tag('redactor.css', :plugin => 'redmine_redactor_js_editor') +
            initial_setup + replace_editor_tag(field_id)
      end
    end

    def initial_page_content(page)
      "<h1>#{ERB::Util.html_escape page.pretty_title}</h1>"
    end

    def heads_for_wiki_formatter
    end
  end
end
