require 'spec_helper'

def bytecode(*bytes)
  bytes.map(&:chr).join
end

describe BrainLove::Compiler do
  let(:compiler) { BrainLove::Compiler.new }

  it "emits INC_DP" do
    compiler.inc_dp
    compiler.bytecode.should == bytecode(BrainLove::VM::INC_DP)
  end

  it "emits DEC_DP" do
    compiler.dec_dp
    compiler.bytecode.should == bytecode(BrainLove::VM::DEC_DP)
  end

  it "emits INC_BYTE" do
    compiler.inc_byte
    compiler.bytecode.should == bytecode(BrainLove::VM::INC_BYTE)
  end

  it "emits DEC_BYTE" do
    compiler.dec_byte
    compiler.bytecode.should == bytecode(BrainLove::VM::DEC_BYTE)
  end

  it "emits PUTC" do
    compiler.putc
    compiler.bytecode.should == bytecode(BrainLove::VM::PUTC)
  end

  it "emits GETC" do
    compiler.getc
    compiler.bytecode.should == bytecode(BrainLove::VM::GETC)
  end

  it "emits JMPFZ" do
    compiler.jmpfz(0)
    compiler.bytecode.should == bytecode(BrainLove::VM::JMPFZ, 0)
  end

  it "emits JMPBNZ" do
    compiler.jmpbnz(3)
    compiler.bytecode.should == bytecode(BrainLove::VM::JMPBNZ, 3)
  end
end
