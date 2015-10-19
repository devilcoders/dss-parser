# DSS Parser for Ruby

A parser for DSS comments in CSS.

DSS allows documentation of CSS using comments in CSS files, designed to be machine readable for living style guides.  For more information on DSS [https://github.com/DSSWG/DSS](https://github.com/DSSWG/DSS).

This has a couple of additional parsers beyond the DSS spec
 - Variables for mixins in scss
 - Section to organise the classes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dss_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dss-parser

## Usage

To use DSS create an instance of dss-parser parsing in a folder containing your css.  It will recusivly pass any css/scss files in that directory. And then find any DSS comments.

```ruby
parser = DssParser.new('/path/to/stylesheets')
dss = parser.get_dss
```

This will create an array of DSS comments that can be used e.g.

```ruby
dss.each do |d|
  d.name
  d.description
  d.markup
  d.section
  d.states.each do |state|
    state.name
    state.description
  end
  d.variables.each do |variable|
    variable.name
    variable.description
  end
end
```

## Additional Parsers

The gem contains parsers for the main DSS attributes but can be extended with your own parsers.

```ruby
parser = DssParser.new('/path/to/stylesheet')
parser.register_parser(MyParser::AdditionalAttribute)
dss = parser.get_dss
```

To create your own parser take a look at the parsers in lib/dss_parser/parsers.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dss-parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
