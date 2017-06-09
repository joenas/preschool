require 'rails_helper'

describe Listeners::PostNewSiteChangeToPushover do

  subject{described_class.new}

  Given(:site_change){create :site_change, note: note}
  Given(:params){{}}

  describe '#create_success' do
    Given(:expected_body) do
      {
        "token": ENV['PUSHOVER_API_TOKEN'],
        "user": ENV['PUSHOVER_API_USER'],
        "title": site_change.preschool.name,
        "url": admin_preschool_url(site_change.preschool),
        "url_title": site_change.preschool.name,
        "message": message,
        "html": "1"
      }
    end
    Given!(:stubbed_request){stub_request(:post, "https://api.pushover.net/1/messages.json").with(body: expected_body)}

    When{subject.create_success(site_change, params)}

    context "with a note" do
      Given(:note){'some text'}
      Given(:message){site_change.note}
      Then{expect(stubbed_request).to have_been_requested}
    end

    context "without a note" do
      Given(:note){nil}
      Given(:message){'<i>Ny uppdatering</i>'}
      Then{expect(stubbed_request).to have_been_requested}
    end

  end
end
