class DssParser
  class Parser
    class RenderExample
      def self.parse(lines)
        render_example = {}

        lines.each do |line|
          type, content = line.split(' ', 2)

          if type == '@render_example'
            render_example =  { render_example: content }
          end
        end

        render_example
      end
    end
  end
end
