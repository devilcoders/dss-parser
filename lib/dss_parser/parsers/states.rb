class DssParser
  class Parser
    class States
      def self.parse(lines)
        temp_d = []

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@state"
            name, description = content.split("-", 2)

            temp_d.push({name: name.strip, description: description.strip})
          end
        end

        return {states: temp_d}
      end
    end
  end
end
