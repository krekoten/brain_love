module BrainLove
  class Transformer < Parslet::Transform
    rule(:increment_pointer => simple(:_))  { AST::IncrementPointer.new }
    rule(:decrement_pointer => simple(:_))  { AST::DecrementPointer.new }
    rule(:increment_byte    => simple(:_))  { AST::IncrementByte.new }
    rule(:decrement_byte    => simple(:_))  { AST::DecrementByte.new }
    rule(:output_byte       => simple(:_))  { AST::OutputByte.new }
    rule(:input_byte        => simple(:_))  { AST::InputByte.new }

    rule(:loop => simple(:_)) do
      AST::Loop.new
    end

    rule(:loop => sequence(:statements)) do
      AST::Loop.new(statements.first)
    end

    rule :statements => simple(:statements) do
      AST::Statements.new([statements])
    end

    rule :statements => sequence(:statements) do
      AST::Statements.new(statements)
    end
  end
end
