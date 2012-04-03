module BrainLove
  class VM

    INC_DP    = 1
    DEC_DP    = 2
    INC_BYTE  = 3
    DEC_BYTE  = 4
    PUTC      = 5
    GETC      = 6
    JMPFZ     = 7
    JMPBNZ    = 8

    attr_reader :ip, :dp, :code, :data

    def initialize(code, data = [0] * 30_000, input = STDIN, output = STDOUT)
      @code, @data, @input, @output = code, data, input, output
      @ip = 0
      @dp = 0
    end

    def execute
      while @ip < @code.bytesize do
        case @code[@ip].ord
        when INC_DP
          @dp += 1
        when DEC_DP
          @dp -= 1
        when INC_BYTE
          @data[@dp] += 1
        when DEC_BYTE
          @data[@dp] -= 1
        when PUTC
          @output.putc(@data[@dp].chr)
        when GETC
          @data[@dp] = @input.getc.ord
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
