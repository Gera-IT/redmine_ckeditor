module RedmineRedactor
  module WikiPagePatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :diff, :redactor
      end
    end

    module InstanceMethods
      def diff_with_redactor(version_to=nil, version_from=nil)
        p 'why u y loading?'
        version_to = version_to ? version_to.to_i : self.content.version
        content_to = content.versions.find_by_version(version_to)
        content_from = version_from ? content.versions.find_by_version(version_from.to_i) : content_to.try(:previous)
        return nil unless content_to && content_from

        if content_from.version > content_to.version
          content_to, content_from = content_from, content_to
        end

        if content_to.project.respond_to?(:text_formatting) && content_to.project.text_formatting == "Imperavi Redactor"
        RedmineRedactor::WikiFormatting::Helper::Diff.new(content_to, content_from)
        else
          (content_to && content_from) ? WikiDiff.new(content_to, content_from) : nil
        end
      end
    end

  end


end