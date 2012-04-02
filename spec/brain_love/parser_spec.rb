require 'spec_helper'

describe BrainLove::Parser do
  describe 'increment the pointer' do
    subject { BrainLove::Parser.new.increment_pointer }

    it { should parse('>') }
  end

  describe 'decrement the pointer' do
    subject { BrainLove::Parser.new.decrement_pointer }

    it { should parse('<') }
  end

  describe 'increment the byte at the pointer' do
    subject { BrainLove::Parser.new.increment_byte }

    it { should parse('+') }
  end

  describe 'decrement the byte at the pointer' do
    subject { BrainLove::Parser.new.decrement_byte }

    it { should parse('-') }
  end

  describe 'output the byte at the pointer' do
    subject { BrainLove::Parser.new.output_byte }

    it { should parse('.') }
  end

  describe 'input a byte and sore at the pointer' do
    subject { BrainLove::Parser.new.input_byte }

    it { should parse(',') }
  end

  describe 'jump forward if the byte at the pointer is zero' do
    subject { BrainLove::Parser.new.jump_forward }

    it { should parse('[') }
  end

  describe 'jump backward if the byte at the pointer is zero' do
    subject { BrainLove::Parser.new.jump_backward }

    it { should parse(']') }
  end

  describe 'integration' do
    it { should parse('[+++>++<--]') }
    it { should parse('[]') }
    it { should parse('++[]') }
    it { should parse('[[]]') }
    it { should parse('[[++]++]>.') }

    it { should_not parse('[') }
    it { should_not parse(']') }
  end
end
