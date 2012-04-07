module BrainLove
  module AST

    class Node
      attr_reader :value

      def initialize(value = nil)
        @value = value
      end

      def ==(other)
        self.class == other.class &&
        self.value == other.value
      end

      def accept(visitor)
        visitor.send("visit_#{self.class.to_s.split('::').last}", self)
      end
    end

    class Statements < Node; end
    class IncrementPointer < Node; end
    class DecrementPointer < Node; end
    class IncrementByte < Node; end
    class DecrementByte < Node; end
    class OutputByte < Node; end
    class InputByte < Node; end
    class Loop < Node; end

  end
end
