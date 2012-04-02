require 'spec_helper'

describe BrainLove::Transformer do
  describe 'simple commands' do
    it { should transform('>').to(BrainLove::AST::Statements.new([BrainLove::AST::IncrementPointer.new])) }
    it { should transform('<').to(BrainLove::AST::Statements.new([BrainLove::AST::DecrementPointer.new])) }
    it { should transform('+').to(BrainLove::AST::Statements.new([BrainLove::AST::IncrementByte.new])) }
    it { should transform('-').to(BrainLove::AST::Statements.new([BrainLove::AST::DecrementByte.new])) }
    it { should transform('.').to(BrainLove::AST::Statements.new([BrainLove::AST::OutputByte.new])) }
    it { should transform(',').to(BrainLove::AST::Statements.new([BrainLove::AST::InputByte.new])) }
  end

  describe 'loop' do
  end
end
