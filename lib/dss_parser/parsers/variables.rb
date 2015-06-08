class DssParser
  class Parser
    class Variables
      def self.parse(lines)
        variables = []
        Struct.new("Variable", :name, :description) unless defined?(Struct::Variable)

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@variable"
            name, description = content.split("-", 2)

            variables.push(Struct::Variable.new(name.strip, description.strip))
          end
        end

        return {variables: variables}
      end
    end
  end
end
