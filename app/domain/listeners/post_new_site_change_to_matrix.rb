module Listeners
  class PostNewSiteChangeToMatrix
    include Rails.application.routes.url_helpers

    def initialize
      @client = JsonClient.new(ENV['MATRIX_URL'])
    end

    def create_success(site_change, params)
      return unless @client.host
      room = ENV['MATRIX_ROOM']
      note = (site_change.note || '<i>Ny uppdatering</i>')
      url = site_change.preschool.url
      title = site_change.preschool.name
      html_note = note.gsub("\n", "<br>")
      @client.post("_matrix/client/r0/rooms/#{room}/send/m.room.message?access_token=#{ENV['MATRIX_ACCESS_TOKEN']}", {
        "msgtype": "m.text",
        "body": "%s\n%s\n%s" % [url, title, note],
        "formatted_body": "<b><a href='%s'>%s</a></b><br>%s" % [url, title, html_note],
        "format": "org.matrix.custom.html"
      })
    end

    alias :update_success :create_success

    def create_failure(*)
    end

    alias :update_failure :create_failure
  end
end
