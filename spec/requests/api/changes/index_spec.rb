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
    Given(:preschool_1_hours){parsed_response["hours"][preschool_1.id.to_s]}
    Given(:preschool_2_hours){parsed_response["hours"][preschool_2.id.to_s]}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response["preschools"].first["id"]).to eq preschool_1.id}
    And{expect(parsed_response["preschools"].first["distance"]).to be_nil}
    And{expect(parsed_response["preschools"].second["id"]).to eq preschool_2.id}
    And{expect(preschool_1_hours.length).to eq 3}
    And{expect(preschool_1_hours.last["closes_at"].to_date).to eq 1.week.from_now.to_date}
    And{expect(preschool_1_hours.first["id"]).to_not eq preschool_1_hours.last["id"]}
    And{expect(preschool_2_hours.length).to eq 2}
  end

  context "with a properly formatted request, no position" do
    Given(:params){{}}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response["preschools"].first["id"]).to eq preschool_1.id}
    And{expect(parsed_response["preschools"].first["distance"]).to be_nil}
    And{expect(parsed_response["preschools"].second["id"]).to eq preschool_2.id}
  end

end
