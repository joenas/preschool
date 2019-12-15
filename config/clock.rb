require 'clockwork'
require './config/boot'
require './config/environment'

# Make sure that all interactions and other things in this class are strictly asynchronous in nature.
# Keep them simple to limit the risk of having one of them crash and then the entire Clockwork process dies.

module Clockwork

  error_handler do |error|
    Raven.capture_exception(error)
  end

  every(30.minutes, 'Parse preschool urls', if: lambda { |t| t.hour >= 7 && t.hour < 18 }) do
    PreschoolUrl.where(error_on_check: false).each do |purl|
      CheckPreschoolUrlWorker.perform_async(purl.id)
    end
  end

  # TODO:
  # every(1.day, 'Check for failed urls', at: '18:00') do
  #   if PreschoolUrl.where(error_on_check: true).any?)

  #   end
  # end

  every(1.day, 'Remove old SiteChanges & TempHours', at: '06:00') do
    SiteChange.where("updated_at::date < ?", 2.week.ago).where.not(state: :done).find_each do |site_change|
      params = {id: site_change.id, state: :done}
      Resources::Update.new(klass: SiteChange, params: params, listeners: [Listeners::TrainNewSiteChange.new]).perform
    end
    TempHour.where("opens_at::date < current_date").delete_all
  end

end
