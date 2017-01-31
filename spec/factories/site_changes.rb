# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_change do
    association :preschool
    data {{hours: '<strong>some html</strong>', extra: 'more text'}}
  end
end
