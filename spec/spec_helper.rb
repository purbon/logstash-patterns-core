require "logstash/devutils/rspec/spec_helper"
require 'rspec/expectations'

# running the grok code outside a logstash package means
# LOGSTASH_HOME will not be defined, so let's set it here
# before requiring the grok filter
unless LogStash::Environment.const_defined?(:LOGSTASH_HOME)
  LogStash::Environment::LOGSTASH_HOME = File.expand_path("../", __FILE__)
end

require "logstash-helpers"

LogstashHelpers.configure do |config|
  config.test_framework = :rspec
  config.logstash_home  = File.expand_path("../", __FILE__)
end
