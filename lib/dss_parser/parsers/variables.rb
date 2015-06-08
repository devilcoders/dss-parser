class DssParser
  class Parser
    class Variables
      def self.parse(lines)
        variables = []

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@variable"
            name, description = content.split("-", 2)

            variables.push({name: name.strip, description: description.strip})
          end
        end

        return {variables: variables}
      end
    end
  end
end
