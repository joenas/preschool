require 'rails_helper'

describe Commands::CheckPreschoolUrl do

  subject{described_class.new(preschool_url_id)}

  Given(:preschool_url){create :preschool_url}
  Given(:preschool_url_id){preschool_url.id}

  describe '#perform' do
    context "successful request" do
      Given(:fixture){File.open(Rails.root.join("spec/fixtures/homepage.html"))}
      Given!(:stubbed_request){stub_request(:get, preschool_url.url).to_return(body: fixture)}
      Given!(:pushover_request){stub_request(:any, ENV['PUSHOVER_API_URL'])}

      Given(:site_change){SiteChange.where(preschool_id: preschool_url.preschool_id).last}
      Given(:expected_data){{
        "extra" => "<span id=\"extras_element\" class=\"bold\">\n                  Stängt\n                </span>",
        "hours" => "<div class=\"sm-col sm-col-12 md-col-4 lg-col-4\" id=\"hours\">\n                <span class=\"bold\">\n                  Stängt\n                </span>\n                <div class=\"flex-column mt1\">\n                  Morgondagens tider\n                  <li>\n                    <span>\n                      <time>09:00</time>\n                      -\n                      <time>11:00</time>\n                    </span>\n                    <small class=\"ml1 xs-hide\">Babycafe!</small>\n                  </li>\n                  <li>\n                    <span>\n                      <time>11:00</time>\n                      -\n                      <time>14:00</time>\n                    </span>\n                    <small class=\"ml1 xs-hide\"></small>\n                  </li>\n                </div>\n              </div>"

        }}

      Given do
        File.read('spec/fixtures/good_site_changes.txt').lines.each {|line| ServiceRegistry.classifier.train 'Goodsitechange', line}
      end
      Given{ServiceRegistry.classifier.train 'Badsitechange', "Kompassen"}

      When{subject.perform()}

      context "with no previous site change and note is predicted" do
        # Given{ServiceRegistry.classifier.train 'Badsitechange', "random string"}
        Then{expect(site_change.data).to eq expected_data}
        And{expect(site_change.state).to eq "predicted"}
        And{expect(site_change.note).to eq "Stängt"}
        And{expect(SiteChange.count).to eq 1}
        And{expect(pushover_request).to have_been_requested}
      end

      context "with no previous site change and note is not predicted" do
        Given(:preschool_url){create :preschool_url, extras_element: ".text-default"}

        Then{expect(site_change.data["extra"]).to include("Barnens Hus")}
        And{expect(site_change.state).to eq "new"}
        And{expect(site_change.note).to be_nil}
        And{expect(SiteChange.count).to eq 1}
        And{expect(pushover_request).to have_been_requested}
      end

      context "with previous site change AKA nothing new" do
        Given{create :site_change, preschool_id: preschool_url.preschool_id, data: expected_data}
        Then{expect(SiteChange.count).to eq 1}
        And{expect(pushover_request).to_not have_been_requested}
      end
    end

    context "failed request" do
      Given!(:stubbed_request){stub_request(:get, preschool_url.url).to_return(status: 500)}
      When(:result){subject.perform}
      Then{expect(result).to have_failed}
      And{expect(preschool_url.reload.error_on_check).to be_truthy}
    end
  end
end
