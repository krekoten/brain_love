module BrainLove
  class VM

    NOOP      = 0
    INC_DP    = 1
    DEC_DP    = 2
    INC_BYTE  = 3
    DEC_BYTE  = 4
    PUTC      = 5
    GETC      = 6
    JMPFZ     = 7
    JMPBNZ    = 8

    attr_reader :ip, :dp, :code, :data

    def initialize(code, input, output)
      @code, @input, @output = code, input, output
      @ip = 0
      @dp = 0
      @data = [0] * 30_000
    end

    def code_dump
      index = 0, jmp = false
      @code.each_byte do |b|
        print "#{index} "
        index += 1
        case b
        when NOOP
          puts "NOOP"
        when INC_DP
          puts "INC_DP"
        when DEC_DP
          puts "DEC_DP"
        when INC_BYTE
          puts "INC_BYTE"
        when DEC_BYTE
          puts "DEC_BYTE"
        when PUTC
          puts "PUTC"
        when GETC
          puts "GETC"
        when JMPFZ
          puts "JMPFZ"
          jmp = true
        when JMPBNZ
          puts "JMPBNZ"
          jmp = true
        else
          if jmp
            jmp = false
            puts " offset #{b}"
          else
            puts "UNKNOWN BYTECODE"
          end
        end
      end
    end

    def execute
      while @ip < @code.bytesize do
        case @code[@ip].ord
        when NOOP
        when INC_DP
          @dp += 1
        when DEC_DP
          @dp -= 1
        when INC_BYTE
          @data[@dp] = 0 if @data[@dp] == 255
          @data[@dp] += 1
        when DEC_BYTE
          @data[@dp] = 256 if @data[@dp] == 0
          @data[@dp] -= 1
        when PUTC
          @output.putc(@data[@dp].chr)
        when GETC
          @data[@dp] = (@input.getc || 0).ord
        when JMPFZ
          @ip += @code[@ip + 1].ord - 1 if @data[@dp] == 0
        when JMPBNZ
          unless @data[@dp] == 0
            @ip -= @code[@ip + 1].ord
          else
            @ip += 1
          end
        end

        @ip += 1
      end
    end
  end
end
