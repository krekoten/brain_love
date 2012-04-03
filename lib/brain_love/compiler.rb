module BrainLove
  class Compiler

    attr_reader :bytecode

    def initialize
      @bytecode = ""
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

    def jmpfz(offset)
      @bytecode << VM::JMPFZ.chr << offset.chr
    end

    def jmpbnz(offset)
      @bytecode << VM::JMPBNZ.chr << offset.chr
    end

    def offset
      @bytecode.bytesize
    end
  end
end
