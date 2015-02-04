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

    $('##{field_id}').redactor();
      })();
      EOT
    end

    def overwrite_functions
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
