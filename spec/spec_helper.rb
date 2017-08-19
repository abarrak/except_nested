require "bundler/setup"

require 'simplecov'
SimpleCov.start { add_filter "/spec/" }

require "except_nested"

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
