# -*- encoding: utf-8 -*-
require File.expand_path('../lib/brain_love/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marjan Krekoten' (Мар'ян Крекотень)"]
  gem.email         = ["krekoten@gmail.com"]
  gem.description   = %q{Brainfuck implementation for fun and love}
  gem.summary       = %q{Brainfuck}
  gem.homepage      = "http://krekoten.github.com/brain_love"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "brain_love"
  gem.require_paths = ["lib"]
  gem.version       = BrainLove::VERSION

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_runtime_dependency "parslet"
end
