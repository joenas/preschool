module Commands
  class CheckPreschoolUrl

    delegate :preschool_id, :hours_element, :extras_element, to: :@resource

    def initialize(preschool_url_id)
      @resource = PreschoolUrl.find(preschool_url_id)
    end

    def perform
      begin
        resp = HtmlClient.new(@resource.url).get
        doc = Nokogiri::HTML(resp.body)
        # TODO: specs for this
        hours = doc.css(hours_element).to_s.encode("UTF-8", invalid: :replace, replace: "")
        extras = doc.css(extras_element).to_s.encode("UTF-8", invalid: :replace, replace: "")
        params = {preschool_id: preschool_id, data: {hours: hours, extra: extras}}
        existing = SiteChange.where(params).order(id: :desc).first
        create_site_change(params) unless existing
      rescue Faraday::ClientError => error
        @resource.update error_on_check: true
        raise error
      end
    end

    def create_success(*)
    end

    def create_failure(resource, params)
      raise ActiveRecord::RecordInvalid.new(resource)
    end

    private

    def create_site_change(params)
      Resources::Create.new(klass: SiteChange, params: params, listeners: listeners).perform do |change|
        if change.note_prediction
          change.attributes = {note: change.note_prediction, state: :predicted}
        end
      end
    end

    def listeners
      [self, Listeners::PostNewSiteChangeToPushover.new, Listeners::PostNewSiteChangeToSlack.new]
    end
  end
end
