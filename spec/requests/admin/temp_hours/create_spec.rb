require 'rails_helper'

# POST /admin/preschools/:id/temp_hours
describe "Creating temp_hours", type: :request do

  Given(:username){ ENV['HTTP_USERNAME'] }
  Given(:password){ ENV['HTTP_PASSWORD'] }
  Given(:credentials) {{'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}}
  Given(:options){ credentials.merge(format: 'json') }

  Given(:preschool){create :preschool}

  Given(:opens_at){"2019-12-15 08:00"}
  Given(:closes_at){"2019-12-15 18:00"}
  Given(:closed_for_day){"0"}

  Given(:params){{preschool_id: preschool.id, temp_hour: {opens_at: opens_at, closes_at: closes_at, closed_for_day: closed_for_day}}}
  Given(:temp_hour){preschool.temp_hours.last}
  When{post admin_preschool_temp_hours_path(preschool.id), params: params, headers: options}

  context "with a properly formatted request" do
    Then{expect(response.status).to eq 302}
    And{expect(temp_hour.preschool).to eq preschool}
    And{expect(temp_hour.opens_at).to eq opens_at.to_time.to_s}
    And{expect(temp_hour.closes_at).to eq closes_at.to_time.to_s}
    And{expect(temp_hour.closed_for_day).to be_falsey}
  end

  context "with a properly formatted request and closed_for_day"  do
    Given(:closed_for_day){"1"}
    Then{expect(response.status).to eq 302}
    And{expect(temp_hour.preschool).to eq preschool}
    And{expect(temp_hour.opens_at).to eq opens_at.to_time.to_s}
    And{expect(temp_hour.closes_at).to eq closes_at.to_time.to_s}
    And{expect(temp_hour.closed_for_day).to be_truthy}
  end

  context "with a properly formatted request and multiple hours" do
    Given(:opens_at){"2019-12-15 08:00"}
    Given(:closes_at){"2019-12-17 18:00"}
    Given(:first_temp_hour){preschool.temp_hours.first}

    Then{expect(response.status).to eq 302}
    And{expect(preschool.temp_hours.length).to eq 3}
    And{expect(first_temp_hour.opens_at.to_s).to eq "2019-12-15 08:00:00 +0100"}
    And{expect(first_temp_hour.closes_at.to_s).to eq "2019-12-15 18:00:00 +0100"}
    And{expect(first_temp_hour.closed_for_day).to be_falsey}

    And{expect(temp_hour.opens_at.to_s).to eq "2019-12-17 08:00:00 +0100"}
    And{expect(temp_hour.closes_at.to_s).to eq "2019-12-17 18:00:00 +0100"}
    And{expect(temp_hour.closed_for_day).to be_falsey}
  end

  context "with a malformatted request" do
    Given(:opens_at){""}
    Then{expect(response.status).to eq 302}
    And{expect(flash[:error]).to eq ["Invalid dates supplied"]}
  end
end
