class DssParser
  class Parser
    class Variables
      def self.parse(lines)
        temp_d = []

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@variable"
            name, description = content.split("-", 2)

            temp_d.push({name: name.strip, description: description.strip})
          end
        end

        return {variables: temp_d}
      end
    end
  end
end
