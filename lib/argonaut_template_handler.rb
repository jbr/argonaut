
require 'argonaut'

module ActionView
  module TemplateHandlers
    class ArgonautHandler < TemplateHandler
      include Compilable

      def self.line_offset() 2 end

      def compile(template)
        STDOUT.puts 'here'
        <<-END_RUBY
          STDOUT.puts 'htere'
          doc = ::Argonaut.new do |doc|
            #{template.source}
          end.to_json
        END_RUBY
      end

      def cache_fragment(block, name = {}, options = nil)
        @view.fragment_for(block, name, options) do
          eval('doc', block.binding)
        end
      end
    end
  end
end

