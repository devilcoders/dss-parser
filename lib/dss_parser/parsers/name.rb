class DssParser
  class Parser
    class Name

      def self.parse(lines)
        lines.each do |line|
          type, content = line.split(" ", 2)

          return {name: content} if type == "@name"
        end
      end

    end
  end
end
