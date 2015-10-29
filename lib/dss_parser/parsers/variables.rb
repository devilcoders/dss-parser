class DssParser
  class Parser
    class Variables
      def self.parse(lines)
        variables = []
        Struct.new('Variable', :name) unless defined?(Struct::Variable)

        lines.each do |line|
          type, content = line.split(' ', 2)

          if type == '@variables'
            items = content.split(',')
            items.each do |item|
              variables.push(Struct::Variable.new(item.strip))
            end
          end
        end

        { variables: variables }
      end
    end
  end
end
