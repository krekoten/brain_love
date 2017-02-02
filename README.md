# BrainLove

Ruby implementation of [brainfuck](http://esolangs.org/wiki/Brainfuck).

## Installation

Install it as:

```
$ gem install brain_love
```

## Usage

### Standalone

```
# Hello World
$ brain_love -e '>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.>>>++++++++[<++++>-]<.>>>++++++++++[<+++++++++>-]<---.<<<<.+++.------.--------.>>+.'
```

Or from file:

```
$ brain_love some_file.bf
```

### In your code

```ruby
require 'brain_love'

# Hello World
BrainLove.run_string('>+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.>>>++++++++[<++++>-]<.>>>++++++++++[<+++++++++>-]<---.<<<<.+++.------.--------.>>+.')
```

## Portability

 * Data space contains 30 000 cells
 * Data cell is unsigned byte (wraps around)
 * EOF sets data cell to 0
 * Nested loops
 * All unknown characters are considered as comments

## Current limitations

 * jump offsets are 1 byte

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012-2017 Мар'ян Крекотень (Marjan Krekoten'). Distributed under the MIT License. See LICENSE for further details.
