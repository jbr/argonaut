
require 'argonaut'

module ActionView
  module TemplateHandlers
    class ArgonautHandler < TemplateHandler
      include Compilable

      def self.line_offset() 2 end

      def compile(template) %{
        doc = ::Argonaut.new do |doc|
          #{template.source}
        end.to_#{template.format} #{":root => 'response'" if template.format == 'xml'}
      } end

      def cache_fragment(block, name = {}, options = nil)
        @view.fragment_for(block, name, options) do
          eval('doc', block.binding)
        end
      end
    end
  end
end

