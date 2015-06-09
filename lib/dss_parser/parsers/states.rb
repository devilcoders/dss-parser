class DssParser
  class Parser
    class States
      def self.parse(lines)
        states = []
        Struct.new("State", :name, :description) unless defined?(Struct::State)

        lines.each do |line|
          type, content = line.split(" ", 2)

          if type == "@state"
            name, description = content.split(" - ", 2)

            states.push(Struct::State.new(name.strip, description.strip))
          end
        end

        return {states: states}
      end
    end
  end
end
