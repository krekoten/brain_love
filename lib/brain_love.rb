require "brain_love/version"
require "brain_love/ast"
require "brain_love/parser"
require "brain_love/transformer"
require "brain_love/vm"
require "brain_love/compiler"

module BrainLove

  def run_string(code, input = STDIN, output = STDOUT)
    ast = Transformer.new.apply(Parser.new.parse(code))
    compiler = Compiler.new
    ast.accept(compiler)
    VM.new(compiler.bytecode, input, output).execute
  end
  module_function :run_string

  def run_file(file, input = STDIN, output = STDOUT)
    code = File.open(file) { |f| f.read }
    run_string(code, input, output)
  end
  module_function :run_file

end
