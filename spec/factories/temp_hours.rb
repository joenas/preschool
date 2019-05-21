# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :temp_hour do
    association :preschool
    opens_at {Date.today+8.hours}
    closes_at {Date.today+15.hours}
    closed_for_day {false}
  end
end
