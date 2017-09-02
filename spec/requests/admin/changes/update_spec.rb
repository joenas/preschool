require 'rails_helper'

# PUT /admin/site_change/id
describe "Updating site_changes", type: :request do

  Given(:username){ ENV['HTTP_USERNAME'] }
  Given(:password){ ENV['HTTP_PASSWORD'] }
  Given(:credentials) {{'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}}
  Given(:options){ credentials.merge(format: 'json') }

  Given(:preschool){create :preschool}
  Given(:site_change){create :site_change, state: :new, note: 'oh hai', preschool: preschool}

  When{put admin_site_change_path(site_change), params: params, headers: options; site_change.reload}

  context "with a properly formatted request" do
    Given(:params){{id: site_change.id, site_change: {state: :active, note: 'new note'}}}

    Then{expect(response.status).to eq 302}
    And{expect(site_change.preschool).to eq preschool}
    And{expect(site_change.state).to eq 'active'}
    And{expect(site_change.note).to eq 'new note'}
  end

  context "with a malformatted request" do
    Given(:params){{id: site_change.id, site_change: {state: :wrooong}}}
    Then{expect(response.status).to eq 302}
    And{expect(flash[:error]).to_not be_empty}
  end

end
