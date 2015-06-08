class DssParser
  class Parser
    class Section
      def self.parse(lines)
        section = nil
        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@section"
            puts type
            section =  {section: content}
          end
        end

        section
      end
    end
  end
end
