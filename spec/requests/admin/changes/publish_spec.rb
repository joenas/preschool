require 'rails_helper'

# PUT /admin/site_change/id/publish
describe "Updating site_changes", type: :request do

  Given(:username){ ENV['HTTP_USERNAME'] }
  Given(:password){ ENV['HTTP_PASSWORD'] }
  Given(:credentials) {{'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}}
  Given(:options){ credentials.merge(format: 'json') }

  Given(:preschool){create :preschool}
  Given(:site_change){create :site_change, state: :new, note: 'oh hai', preschool: preschool}

  Given!(:stubbed_request){stub_request(:post, /#{ENV['MATRIX_URL']}\/*/)}

  When{put publish_admin_site_change_path(site_change), params: params, headers: options; site_change.reload}

  context "with a properly formatted request, with :state override" do
    Given(:params){{id: site_change.id, site_change: {state: :close, note: 'new note'}}}

    Then{expect(response.status).to eq 302}
    And{expect(site_change.preschool).to eq preschool}
    And{expect(site_change.state).to eq 'active'}
    And{expect(site_change.note).to eq 'new note'}
    And{expect(stubbed_request).to have_been_requested}
  end
end
