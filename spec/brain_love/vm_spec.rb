require 'spec_helper'
require 'stringio'

describe BrainLove::VM do
  let(:data) { [0] * 100 }
  let(:input) { double('input stream') }
  let(:output) { double('output stream') }
  let(:vm) { BrainLove::VM.new(code, data, input, output) }

  describe "initial state" do
    let(:code) { [].join }

    it "sets IP to 0" do
      vm.ip.should == 0
    end

    it "sets DP to 0" do
      vm.dp.should == 0
    end
  end

  describe "INC_DP" do
    let(:code) { [BrainLove::VM::INC_DP].map(&:chr).join }

    it "increments the pointer by one" do
      expect { vm.execute }.to change { vm.dp }.by(1)
    end
  end

  describe "DEC_DP" do
    let(:code) { [BrainLove::VM::INC_DP, BrainLove::VM::DEC_DP].map(&:chr).join }

    it "decrements the pointer by one" do
      expect { vm.execute }.to change { vm.dp }.by(0)
    end
  end

  describe "INC_BYTE" do
    let(:code) { [BrainLove::VM::INC_DP, BrainLove::VM::INC_BYTE].map(&:chr).join }

    it "increments the byte at the pointer by one" do
      expect { vm.execute }.to change { vm.data[1] }.by(1)
    end
  end

  describe "DEC_BYTE" do
    let(:code) { [BrainLove::VM::INC_DP, BrainLove::VM::INC_BYTE, BrainLove::VM::INC_BYTE, BrainLove::VM::DEC_BYTE].map(&:chr).join }

    it "decrements the byte at the pointer by one" do
      expect { vm.execute }.to change { vm.data[1] }.by(1)
    end
  end

  describe "PUTC" do
    let(:code) { ([BrainLove::VM::INC_BYTE] * 97 << BrainLove::VM::PUTC).map(&:chr).join }

    it "sends the byte at the pointer as char to output stream" do
      output.should_receive(:putc).with("a")
      vm.execute
    end
  end

  describe "GETC" do
    let(:code) { [BrainLove::VM::INC_DP, BrainLove::VM::GETC].map(&:chr).join }

    before do
      input.should_receive(:getc).and_return("a")
    end

    it "reads char from input stream" do
      vm.execute
    end

    it "stores char as a byte at the pointer" do
      vm.execute
      vm.data[1].should == 97
    end
  end

  describe "JMPFZ" do
    let(:code) { [BrainLove::VM::JMPFZ, 3, BrainLove::VM::INC_BYTE, BrainLove::VM::INC_DP, BrainLove::VM::GETC, BrainLove::VM::PUTC].map(&:chr).join }

    it "jumps forward if current byte is 0" do
      input.stub(:getc).and_return('t')
      output.should_receive(:putc).with('t')
      expect { vm.execute }.to change { vm.data[0] }.by(0)
    end
  end

  describe "JMPBZ" do
    let(:code) { [BrainLove::VM::INC_BYTE, BrainLove::VM::DEC_BYTE, BrainLove::VM::JMPBZ, 0, BrainLove::VM::INC_BYTE].map(&:chr).join }

    it "jumps bacward unless current byte is 0" do
      expect { vm.execute }.to change { vm.data[0] }.by(1)
    end
  end
end
