require 'rails_helper'

# GET /api/preschools
describe "Fetching ", type: :request do

  Given(:parsed_response){JSON.parse response.body}

  When{get api_preschools_path, params: params}

  Given!(:preschool_1){create :preschool, position: [57.01, 11.00]}
  Given{create :hour, preschool: preschool_1}
  Given{create :hour, preschool: preschool_1, day_of_week: Time.now.wday+1}
  Given!(:preschool_2){create :preschool, position: [56.01, 12.00]}
  Given{create :hour, preschool: preschool_2}

  context "with a properly formatted request" do
    Given(:params){{latitude: "55.00", longitude: "13.232"}}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response["preschools"].first["id"]).to eq preschool_1.id}
    And{expect(parsed_response["preschools"].second["id"]).to eq preschool_2.id}
    And{expect(parsed_response["hours_today"].length).to eq 2}
    And{expect(parsed_response["hours_tomorrow"].length).to eq 1}
  end

  context "with a properly formatted request, no position" do
    Given(:params){{}}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response["preschools"].first["id"]).to eq preschool_1.id}
    And{expect(parsed_response["preschools"].second["id"]).to eq preschool_2.id}
  end

end
