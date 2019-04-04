require 'rails_helper'

# GET /api/preschools
describe "Fetching ", type: :request do

  Given(:parsed_response){JSON.parse response.body}

  When{get api_preschools_path, params: params}

  Given!(:preschool_1){create :preschool}
  Given!(:preschool_2){create :preschool}

  context "with a properly formatted request" do
    Given(:params){{latitude: "55.00", longitude: "13.232"}}

    Then{puts parsed_response; expect(response.status).to eq 200}
    # TODO add specs for sorting
  end

  context "with a properly formatted request, no position" do
    Given(:params){{}}

    Then{expect(response.status).to eq 200}
  end

end
