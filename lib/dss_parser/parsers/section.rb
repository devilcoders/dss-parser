class DssParser
  class Parser
    class Section
      def self.parse(lines)
        section = {}

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@section"
            section =  {section: content}
          end
        end

        return section
      end
    end
  end
end
