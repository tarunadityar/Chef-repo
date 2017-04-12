# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

## chef spec
require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start

Dir['../libraries/*.rb'].each { |f| require f }
Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.log_level = :error

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  ## setup fauxhai to be redhat 6.5
  config.platform = 'redhat'
  config.version  = '6.5'
end

## setup default chef run for chefspec
def default_chef_run(&block)
  ChefSpec::ServerRunner.new do |node|
    ## allow the runner to be configured like it would normally by calling any
    ## passed in block.
    block.call node unless block.nil?
  end.converge described_recipe
end
at_exit { ChefSpec::Coverage.report! }