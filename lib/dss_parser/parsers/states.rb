class DssParser
  class Parser
    class States
      def self.parse(lines)
        states = []

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@state"
            name, description = content.split("-", 2)

            states.push({name: name.strip, description: description.strip})
          end
        end

        return {states: states}
      end
    end
  end
end
