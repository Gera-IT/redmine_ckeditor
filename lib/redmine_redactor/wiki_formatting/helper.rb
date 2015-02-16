module RedmineRedactor::WikiFormatting
  module Helper
    class Diff
      include ActionView::Helpers::SanitizeHelper

      attr_reader :content_to, :content_from

      def initialize(content_to, content_from)
        @content_to = content_to
        @content_from = content_from
        @words = content_to.text.to_s.gsub("><", "><")
        @words = @words.gsub("<br>", "\n")
        @words = @words.gsub("</p>", "\n")
        @words = @words.gsub("</li>", "\n")
        @words = @words.gsub("</tr>", "\n")
        @words = @words.gsub("<td>", " | ")
        @words = @words.gsub(/<.*?>/, "")
        @words = strip_tags(@words)
        @words << "\n"
        words_from = content_from.text.to_s.gsub("><", "><")
        words_from = words_from.gsub("<br>", "\n")
        words_from= words_from.gsub("</p>", "\n")
        words_from= words_from.gsub("</li>", "\n")
        words_from = words_from.gsub("</tr>", "\n")
        words_from = words_from.gsub("<td>", " | ")
        words_from = words_from.gsub(/<.*?>/, "")
        @words_from = strip_tags(words_from)
        @words_from << "\n"
        @diff = words_from.diff @words
      end

      def to_html
        dff = Diffy::Diff.new(@words_from, @words)
        dff.to_s(:html)
      end
    end


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
        imageUpload: '/pictures.json?key=#{user_api_key}',
        imageManagerJson: '/pictures.json?key=#{user_api_key}',
        fileUpload: '/documents.json?key=#{user_api_key}',
        fileManagerJson: '/documents.json?key=#{user_api_key}',
        plugins: ['filemanager', 'imagemanager', 'table', 'video', 'fullscreen', 'fontsize', 'fontfamily', 'fontcolor', 'checkbox']
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
