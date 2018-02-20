require 'clockwork'
require './config/boot'
require './config/environment'

# Make sure that all interactions and other things in this class are strictly asynchronous in nature.
# Keep them simple to limit the risk of having one of them crash and then the entire Clockwork process dies.

module Clockwork

  error_handler do |error|
    Rollbar.error(error)
  end

  every(30.minutes, 'Parse preschool urls', if: lambda { |t| t.hour >= 7 && t.hour < 18 }) do
    client = JsonClient.new(ENV['HUGINN_TRIGGER_PARSE_URL'])
    PreschoolUrl.find_each do |purl|
      client.post('', purl.attributes.except('created_at', 'updated_at'))
      sleep 60
    end
  end

  every(1.day, 'Remove old SiteChanges', at: '06:00') do
    SiteChange.where("created_at::date < ?", 1.week.ago).where.not(state: :done).find_each do |site_change|
      params = {id: site_change.id, state: :done}
      Resources::Update.new(klass: SiteChange, params: params, listeners: [Listeners::TrainNewSiteChange.new]).perform
    end
  end

end
