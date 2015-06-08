class DssParser
  class Parser
    class Name
      def self.parse(lines)
        name = nil
        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@name"
            name = {name: content}
          end
        end

        name
      end
    end
  end
end
