# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :preschool do
    name 'Some name'
    url 'http://example.com'
    street_name 'Gatan 1'
    postal_code '13370'
    city 'Staden'
  end
end
