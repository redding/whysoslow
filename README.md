# Whysoslow

## Description

Whysoslow is a little runner/printer I wrote to benchmark my Ruby code.  It runs a block of code, collects run time measurements, and can snapshot memory usage information at various points during execution.

It has no tests, shockingly sparse docs, and is more of an experiment at this point.  It comes as is for now so use if you see fit.  I will happily accept any pull requests for documentation, tests, extensions, and improvements.

## Usage

```ruby
require 'whysoslow'

printer = Whysoslow::DefaultPrinter.new({
  :title => "Bench Report Title",
  :verbose => true
})

runner = Whysoslow::Runner.new(@printer)

runner.run do
  # ... some long running script or loop
  runner.snapshot("mem usage during run")
  # ... some more long running script or loop
end
```

## Output: DefaultPrinter

The DefaultPrinter outputs to an io stream ($stdout by default).  It uses Ansi to output columned memory usage snapshot data and measurement data.

## Installation

Add this line to your application's Gemfile:

    gem 'whysoslow'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install whysoslow

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
