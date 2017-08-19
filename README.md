# Except Nested
[![Gem Version](https://badge.fury.io/rb/except_nested.svg)](https://rubygems.org/gems/except_nested)
[![Build Status](https://travis-ci.org/abarrak/except_nested.svg?branch=master)](https://travis-ci.org/abarrak/except_nested)
[![Test Coverage](https://codeclimate.com/github/abarrak/except_nested/badges/coverage.svg)](https://codeclimate.com/github/abarrak/except_nested/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/abarrak/except_nested.svg)](https://gemnasium.com/github.com/abarrak/except_nested)

**except_nested** allows exclusion of given hash keys at various depth of the hash.

It's an extended version of active_support `#except` hash utility.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'except_nested'
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install except_nested
```

## Usage
Given the following hash:

```ruby
h = { name: 'Zohoor', degree: 'Psychology', preferences: { color: 'mauve', drink: 'coffee', pet: 'cat' } }
```

You can deep except keys:

```ruby
h.except_nested(:degree, preferences: [:color, :pet])
=> { name: "Zohoor", preferences: { drink: "coffee" } }

h.except_nested(preferences: :pet)
=> { name: "Zohoor", degree: "Psychology", preferences: { color: "mauve", drink: "coffee" } }

h.except_nested(preferences: [:pet], :name)
=> { degree: "Psychology", preferences: { color: "mauve", drink: "coffee" } }

h.except_nested(:degree, preferences: [:color, :pet, :drink])
=> { name: "Zohoor" }

# original hash is preserved ..
h
=> { name: "Zohoor", degree: "Psychology", preferences: { color: "mauve", drink: "coffee", pet: "cat" } }
```

Or exclude keys in the first level just like normal `#except` does:

```ruby
h.except_nested(:name)
=> { degree: "Psychology", preferences: { color: "mauve", drink: "coffee", pet: "cat" } }

h.except_nested(:name, :degree)
=> { preferences: { color: "mauve", drink: "coffee", pet: "cat" } }

h.except_nested(:name, :degree, :preferences)
=> {}
```

It works for any nested levels. Check [test case](https://github.com/abarrak/except_nested/blob/master/spec/except_nested_spec.rb#L87-L105) for 3-level depth example.

## Documentation

[RDoc version](http://www.rubydoc.info/gems/except_nested) at RubyDoc.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/abarrak/except_nested).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
