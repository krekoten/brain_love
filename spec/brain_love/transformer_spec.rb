require 'spec_helper'

def ast_statement(nodes)
  BrainLove::AST::Statements.new(nodes)
end

describe BrainLove::Transformer do
  describe 'simple commands' do
    it { should transform('>').to(ast_statement([BrainLove::AST::IncrementPointer.new])) }
    it { should transform('<').to(ast_statement([BrainLove::AST::DecrementPointer.new])) }
    it { should transform('+').to(ast_statement([BrainLove::AST::IncrementByte.new])) }
    it { should transform('-').to(ast_statement([BrainLove::AST::DecrementByte.new])) }
    it { should transform('.').to(ast_statement([BrainLove::AST::OutputByte.new])) }
    it { should transform(',').to(ast_statement([BrainLove::AST::InputByte.new])) }
  end

  describe 'loop' do
    it { should transform('[]').to(ast_statement([BrainLove::AST::Loop.new(ast_statement([]))])) }
  end
end
