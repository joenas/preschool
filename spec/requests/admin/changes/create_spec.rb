require 'rails_helper'

# POST /admin/changes
describe "Creating changes", type: :request do

  Given(:username){ ENV['HTTP_USERNAME'] }
  Given(:password){ ENV['HTTP_PASSWORD'] }
  Given(:credentials) {{'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}}
  Given(:options){ credentials.merge(format: 'json') }

  When{post admin_changes_path, params: params, headers: options}

  context "with a properly formatted request" do
    Given(:params){{preschool_id: preschool.id, data: {hours: 'something', extra: 'extrastuff'}}}
    Given(:parsed_response){JSON.parse response.body}
    Given(:preschool){create :preschool}
    Given(:change){Change.last}

    Then{expect(response.status).to eq 200}
    And{expect(change.preschool).to eq preschool}
    And{expect(change.state).to eq 'active'}
    And{expect(change.data).to eq({'hours' => 'something', 'extra' => 'extrastuff'})}
  end

  context "with a malformatted request" do
    Given(:params){{preschool_id: '', data: {not_allowed: :sup}}}
    Then{expect(response.status).to eq 422}
  end
end
