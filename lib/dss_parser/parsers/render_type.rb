class DssParser
  class Parser
    class RenderType
      def self.parse(lines)
        render_type = {}

        lines.each do |line|
          type, content = line.split(' ', 2)

          render_type =  { render_type: content } if type == '@render_type'
        end

        render_type
      end
    end
  end
end
