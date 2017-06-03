require 'rails_helper'

# POST /admin/site_changes
describe "Creating site_changes", type: :request do

  Given(:username){ ENV['HTTP_USERNAME'] }
  Given(:password){ ENV['HTTP_PASSWORD'] }
  Given(:credentials) {{'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}}
  Given(:options){ credentials.merge(format: 'json') }

  When{post admin_site_changes_path, params: params, headers: options}

  Given(:new_note){'stängt'}

  before :each do
    #Redis.new.flushall
    #ServiceRegistry.reset
  end

  context "with a properly formatted request" do
    Given(:params){{preschool_id: preschool.id, data: {hours: 'something', extra: 'notimportant'}}}
    Given{ServiceRegistry.classifier.train 'Badsitechange', params[:data][:extra]}
    Given(:parsed_response){JSON.parse response.body}
    Given(:preschool){create :preschool}
    Given(:change){SiteChange.last}

    Then{expect(response.status).to eq 200}
    And{expect(change.preschool).to eq preschool}
    And{expect(change.state).to eq 'new'}
    And{expect(change.data).to eq({'hours' => 'something', 'extra' => 'notimportant'})}
    And{expect(change.note).to be_nil}
  end

  context "with a properly formatted request and prediction found" do
    Given do
      File.read('spec/fixtures/good_site_changes.txt').lines.each {|line| ServiceRegistry.classifier.train 'Goodsitechange', line}
    end
    Given(:params){{preschool_id: preschool.id, data: {hours: 'something', extra: new_note}}}
    Given(:parsed_response){JSON.parse response.body}
    Given(:preschool){create :preschool}
    Given(:change){SiteChange.last}
    Given!(:stubbed_request){stub_request(:post, ENV['SLACK_URL'])}

    Then{expect(response.status).to eq 200}
    And{expect(change.preschool).to eq preschool}
    And{expect(change.state).to eq 'predicted'}
    And{expect(change.data).to eq({'hours' => 'something', 'extra' => new_note})}
    And{expect(change.note).to eq new_note}
    And{expect(stubbed_request).to have_been_requested}
  end

  context "with empty 'extra'" do
    Given(:params){{preschool_id: preschool.id, data: {hours: 'something', extra: ''}}}
    Given(:parsed_response){JSON.parse response.body}
    Given(:preschool){create :preschool}
    Given(:change){SiteChange.last}

    Then{expect(response.status).to eq 200}
    And{expect(change.preschool).to eq preschool}
    And{expect(change.state).to eq 'new'}
    And{expect(change.data).to eq({'hours' => 'something', 'extra' => ''})}
    And{expect(change.note).to be_nil}
  end

  context "with a malformatted request" do
    Given(:params){{preschool_id: '', data: {not_allowed: :sup}}}
    Then{expect(response.status).to eq 422}
  end
end
