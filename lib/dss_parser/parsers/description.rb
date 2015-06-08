class DssParser
  class Parser
    class Description
      def self.parse(lines)
        description = []
        in_description = false

        lines.each do |line|
          if line.start_with?("@") && line !~ /^@description/  && in_description
            in_description = false
          end

          if line.start_with?("@")
            type, content = line.split(" ", 2)
            if type == "@description"
              in_description = true
              description.push content
            end
          else
            if in_description == true
              description.push line
            end
          end
        end

        return {description: description.join("\n")}
      end
    end
  end
end
