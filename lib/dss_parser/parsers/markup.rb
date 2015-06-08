class DssParser
  class Parser
    class Markup
      def self.parse(lines)
        temp_d = []
        in_markup = false

        lines.each do |line|
          if line.start_with?("@") && line !~ /^@markup/  && in_markup
            in_description = false
          end

          if line.start_with?("@")
            type, content = line.split(" ", 2)
            if type == "@markup"
              in_markup = true
              temp_d.push content
            end
          else
            if in_markup == true
              temp_d.push line
            end
          end
        end

        return {markup: temp_d.join("\n").gsub(/^\n/, '')}
      end
    end
  end
end
