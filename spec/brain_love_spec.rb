require 'spec_helper'
require 'stringio'

describe BrainLove do
  describe '#run_string' do
    it 'executes code from string' do
      output = StringIO.new
      BrainLove.run_string(
        '>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.>>>++++++++[<++++>-]<.>>>++++++++++[<+++++++++>-]<---.<<<<.+++.------.--------.>>+.',
        nil,
        output
      )
      output.string.should == 'Hello World!'
    end
  end

  describe '#run_file' do
    it 'executes code from file' do
      output = StringIO.new
      BrainLove.run_file(
        fixture_path('hello_world.bf'),
        nil,
        output
      )
      output.string.should == 'Hello World!'
    end
  end
end
