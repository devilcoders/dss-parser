class DssParser
  class Parser
    class Description
      def self.parse(lines)
        description = []
        in_description = false

        lines.each do |line|
          if line.include?('@') && line !~ /^@description/ && in_description
            in_description = false
          end

          if line.include?('@')
            type, content = line.split(' ', 2)
            if type == '@description'
              in_description = true
              description.push content
            end
          else
            description.push line if in_description == true
          end
        end

        { description: description.join("\n").lstrip }
      end
    end
  end
end
