class DssParser
  class Parser
    class ExampleOnly
      def self.parse(lines)
        example_only = {}

        lines.each do |line|
          type, content = line.split(' ', 2)

          example_only =  { example_only: content } if type == '@example_only'
        end

        example_only
      end
    end
  end
end
