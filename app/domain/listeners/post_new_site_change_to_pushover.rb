module Listeners
  class PostNewSiteChangeToPushover
    include Rails.application.routes.url_helpers

    def initialize
      @client = JsonClient.new(ENV['PUSHOVER_API_URL']) do |conn|
        conn.request :url_encoded
      end
    end

    def create_success(site_change, params)
      return unless @client.host
      @client.post('', {
        "token": ENV['PUSHOVER_API_TOKEN'],
        "user": ENV['PUSHOVER_API_USER'],
        "title": site_change.preschool.name,
        "url": admin_preschool_url(site_change.preschool),
        "url_title": site_change.preschool.name,
        "message": (site_change.note || '<i>Ny uppdatering</i>'),
        "html": 1
      })
    end

    def create_failure(*)
    end
  end
end
