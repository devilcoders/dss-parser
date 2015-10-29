class DssParser
  class Parser
    class Markup
      def self.parse(lines)
        markup = []
        in_markup = false

        lines.each do |line|
          if line.include?('@') && line !~ /^@markup/ && in_markup
            in_description = false
          end

          if line.include?('@')
            type, content = line.split(' ', 2)
            if type == '@markup'
              in_markup = true
              markup.push content
            end
          else
            markup.push line if in_markup == true
          end
        end

        { markup: markup.join("\n") }
      end
    end
  end
end
