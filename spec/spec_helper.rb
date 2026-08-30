require "kindle_extractor"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.syntax = :expect
  end

  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end
