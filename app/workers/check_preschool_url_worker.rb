class CheckPreschoolUrlWorker
  include Sidekiq::Worker

  def perform(preschool_url_id)
    Commands::CheckPreschoolUrl.new(preschool_url_id).perform
  end
end
