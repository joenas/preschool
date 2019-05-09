FactoryBot.define do
  factory :preschool_url do
    association :preschool
    url { 'http://example.com' }
    hours_element { '#hours' }
    extras_element { '#extras_element' }
  end
end
