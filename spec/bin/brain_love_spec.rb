require 'spec_helper'

def run_brain_love(cmd)
  `#{File.expand_path('../../../bin/brain_love', __FILE__)} #{cmd}`
end

describe 'brain_love' do
  let(:hello_world) { '>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.>>>++++++++[<++++>-]<.>>>++++++++++[<+++++++++>-]<---.<<<<.+++.------.--------.>>+.' }

  describe 'FILE' do
    it 'executes code from file' do
      run_brain_love(fixture_path('hello_world.bf')).should == 'Hello World!'
    end
  end

  describe '-e' do
    it 'executes code' do
      run_brain_love("-e '#{hello_world}'").should == 'Hello World!'
    end
  end
end
