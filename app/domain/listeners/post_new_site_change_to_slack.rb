module Listeners
  class PostNewSiteChangeToSlack
    include Rails.application.routes.url_helpers

    def initialize
      @client = JsonClient.new(ENV['SLACK_URL'])
    end

    def create_success(site_change, params)
      @client.post('', {
       "text": "Ny uppdatering:",
        "attachments": [
          {
            "title": site_change.preschool.name,
            "title_link": admin_preschool_url(site_change.preschool),
            "text": site_change.note
          }
        ]
      }) if site_change.note.present?
    end

    def create_failure(*)
    end
  end
end
