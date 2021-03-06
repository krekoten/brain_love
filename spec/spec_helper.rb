require 'brain_love'

def fixture_path(name)
  File.expand_path("../fixtures/#{name}", __FILE__)
end

RSpec::Matchers.define :parse do |string_for_parsing|
  match do |parser|
    begin
      parser.parse(string_for_parsing)
      true
    rescue Parslet::ParseFailed, NotImplementedError => e
      @error = parser.error_tree
      false
    end
  end

  failure_message_for_should do |parser|
    "expected #{parser} to parse #{string_for_parsing}\n#{@error}"
  end

  failure_message_for_should_not do |parser|
    "didn't expect #{parser} to parse #{string_for_parsing}"
  end

  description do
    "parse #{string_for_parsing}"
  end
end

RSpec::Matchers.define :transform do |string_for_transforming|
  match do |transformer|
    @intermediate_representation = transformer.apply(@raw_ir = BrainLove::Parser.new.parse(string_for_transforming))
    @node == @intermediate_representation
  end

  chain :to do |node|
    @node = node
  end

  failure_message_for_should do |transformer|
    "expected #{string_for_transforming}\n" <<
    "to be transformed to\n#{@node.inspect}\n" <<
    "got\n#{@intermediate_representation.inspect}\nir:\n#{@raw_ir}"
  end

  description do
    "transform #{string_for_transforming} to AST node"
  end
end
