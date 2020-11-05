# frozen_string_literal: true

require 'bundler/setup'
require 'tiny_goauth/rails'
require 'combustion'

Combustion.initialize! :active_record, :action_controller, :action_view, :sprockets

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include FileUtils
  config.include Helpers::FileDiff
  config.include Helpers::StreamSilence

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
