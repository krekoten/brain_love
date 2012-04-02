require 'parslet'

module BrainLove
  class Parser < Parslet::Parser
    rule(:increment_pointer)  { str('>') }
    rule(:decrement_pointer)  { str('<') }
    rule(:increment_byte)     { str('+') }
    rule(:decrement_byte)     { str('-') }
    rule(:output_byte)        { str('.') }
    rule(:input_byte)         { str(',') }
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

    rule(:commands)           { command.repeat(1) }
    rule(:_loop)              { jump_forward >> (commands | _loop).repeat >> jump_backward }

    rule(:root)               { (_loop | commands).repeat }
  end
end
