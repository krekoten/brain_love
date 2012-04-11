require 'parslet'

module BrainLove
  class Parser < Parslet::Parser
    rule(:increment_pointer)  { str('>').as(:increment_pointer) }
    rule(:decrement_pointer)  { str('<').as(:decrement_pointer) }
    rule(:increment_byte)     { str('+').as(:increment_byte) }
    rule(:decrement_byte)     { str('-').as(:decrement_byte) }
    rule(:output_byte)        { str('.').as(:output_byte) }
    rule(:input_byte)         { str(',').as(:input_byte) }
    rule(:jump_forward)       { str('[') }
    rule(:jump_backward)      { str(']') }

    rule :command do
      increment_pointer |
      decrement_pointer |
      increment_byte    |
      decrement_byte    |
      output_byte       |
      input_byte
    end

    rule :comment do
      (command | jump_forward | jump_backward).absnt? >> any.as(:comment)
    end

    rule :_loop do
      (jump_forward >> root >> jump_backward).as(:loop)
    end

    rule :root do
      (comment | command | _loop).repeat.as(:statements)
    end
  end
end
