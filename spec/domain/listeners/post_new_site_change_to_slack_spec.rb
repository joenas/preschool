require 'rails_helper'

describe Listeners::PostNewSiteChangeToSlack do

  subject{described_class.new}

  Given(:site_change){create :site_change, note: note}
  Given(:params){{}}

  describe '#create_success' do
    Given(:expected_body) do
      {
        'text' => 'Ny uppdatering:',
        'attachments' => [
          {
            title: site_change.preschool.name,
            title_link: admin_preschool_url(site_change.preschool),
            text: site_change.note
          }
        ]
      }
    end
    Given!(:stubbed_request){stub_request(:post, ENV['SLACK_URL']).with(body: expected_body.to_json)}

    When{subject.create_success(site_change, params)}

    context "with a note" do
      Given(:note){'some text'}
      Then{expect(stubbed_request).to have_been_requested}
    end

    context "without a note" do
      Given(:note){nil}
      Then{expect(stubbed_request).to_not have_been_requested}
    end

    context "with no SLACK_URL" do
      Given(:note){'some text'}
      Given{ENV.delete("SLACK_URL")}
      Then{expect(stubbed_request).to_not have_been_requested}
    end

  end
end
