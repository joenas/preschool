require 'rails_helper'

describe Listeners::PostNewSiteChangeToMatrix do

  subject{described_class.new}

  Given(:site_change){create :site_change, note: note}
  Given(:params){{}}
  Given(:url){site_change.preschool.url}
  Given(:title){site_change.preschool.name}
  Given(:note){"some text\n more text"}
  Given(:html_message){"some text<br> more text"}

  Given(:expected_body) do
    {
      "msgtype": "m.text",
      "body": "%s\n%s\n%s" % [url, title, message],
      "formatted_body": "<b><a href='%s'>%s</a></b><br>%s" % [url, title, html_message],
      "format": "org.matrix.custom.html"
    }
  end

  describe '#create_success' do
    Given(:stub_url){"#{ENV['MATRIX_URL']}/_matrix/client/r0/rooms/#{ENV['MATRIX_ROOM']}/send/m.room.message?access_token=#{ENV['MATRIX_ACCESS_TOKEN']}"}
    Given!(:stubbed_request){stub_request(:post, stub_url).with(body: expected_body)}

    When{subject.create_success(site_change, params)}

    context "with a note" do
      Given(:message){site_change.note}
      Then{expect(stubbed_request).to have_been_requested}
    end

    context "without a note" do
      Given(:note){nil}
      Given(:message){'<i>Ny uppdatering</i>'}
      Given(:html_message){message}
      Then{expect(stubbed_request).to have_been_requested}
    end

    context "with no MATRIX_URL" do
      Given{ENV.delete("MATRIX_URL")}
      Given(:message){'<i>Ny uppdatering</i>'}
      Then{expect(stubbed_request).to_not have_been_requested}
    end
  end

  describe '#create_failure' do
    When{subject.create_failure(site_change, params)}
    Then{}
  end


  describe '#update_success' do
    Given(:stub_url){"#{ENV['MATRIX_URL']}/_matrix/client/r0/rooms/#{ENV['MATRIX_ROOM']}/send/m.room.message?access_token=#{ENV['MATRIX_ACCESS_TOKEN']}"}
    Given!(:stubbed_request){stub_request(:post, stub_url).with(body: expected_body)}

    When{subject.update_success(site_change, params)}

    context "with a note" do
      Given(:message){site_change.note}
      Then{expect(stubbed_request).to have_been_requested}
    end

    context "without a note" do
      Given(:note){nil}
      Given(:message){'<i>Ny uppdatering</i>'}
      Given(:html_message){message}
      Then{expect(stubbed_request).to have_been_requested}
    end
  end

  describe '#update_failure' do
    When{subject.update_failure(site_change, params)}
    Then{}
  end

end
