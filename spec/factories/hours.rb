# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :hour do
    association :preschool
    day_of_week {Time.now.wday}
    opens {"12:00"}
    closes {"14:00"}
  end
end
