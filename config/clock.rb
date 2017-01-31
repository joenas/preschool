require 'clockwork'
require './config/boot'
require './config/environment'

# Make sure that all interactions and other things in this class are strictly asynchronous in nature.
# Keep them simple to limit the risk of having one of them crash and then the entire Clockwork process dies.

module Clockwork

  error_handler do |error|
    Rollbar.error(error)
  end

  every(1.hour, 'Parse preschool urls', if: lambda { |t| t.hour >= 8 && t.hour < 18 }) do
    client = JsonClient.new(ENV['HUGINN_TRIGGER_PARSE_URL'])
    PreschoolUrl.find_each do |purl|
      client.post('', purl.attributes.except('created_at', 'updated_at'))
      sleep 60
    end
  end
end
