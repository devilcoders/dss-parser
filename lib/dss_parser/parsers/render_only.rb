class DssParser
  class Parser
    class RenderOnly
      def self.parse(lines)
        render_only = {}

        lines.each do |line|
          type, content = line.split(' ', 2)

          render_only =  { render_only: content } if type == '@render_only'
        end

        render_only
      end
    end
  end
end
