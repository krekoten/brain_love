module BrainLove
  class Compiler

    attr_reader :bytecode, :ip

    def initialize
      @bytecode = ""
      @ip = 0
    end

    def inc_dp
      @bytecode << VM::INC_DP.chr
    end

    def dec_dp
      @bytecode << VM::DEC_DP.chr
    end

    def inc_byte
      @bytecode << VM::INC_BYTE.chr
    end

    def dec_byte
      @bytecode << VM::DEC_BYTE.chr
    end

    def putc
      @bytecode << VM::PUTC.chr
    end

    def getc
      @bytecode << VM::GETC.chr
    end

    def jmpfz(at, offset)
      @bytecode[at] = VM::JMPFZ.chr
      @bytecode[at + 1] = offset.chr
    end

    def jmpbnz(offset)
      @bytecode << VM::JMPBNZ.chr << offset.chr
    end

    def noop
      @bytecode << VM::NOOP
    end

    def current_ip
      @bytecode.bytesize
    end

    def visit_Statements(statements)
      statements.value.each { |st| st.accept(self) }
    end

    def visit_Loop(_loop)
      jmpf_ip = current_ip
      noop
      noop
      _loop.value.accept(self)
      jmpbnz(current_ip - jmpf_ip)
      jmpfz(jmpf_ip, current_ip)
    end

    def visit_DecrementPointer(_)
      dec_dp
    end

    def visit_IncrementPointer(_)
      inc_dp
    end

    def visit_IncrementByte(_)
      inc_byte
    end

    def visit_DecrementByte(_)
      dec_byte
    end

    def visit_OutputByte(_)
      putc
    end

    def visit_InputByte(_)
      getc
    end
  end
end
