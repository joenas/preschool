require 'rails_helper'

describe Preschools::OpenToday do

  subject{described_class.new()}

  Given(:date){"2019-05-10"}
  Given(:now){DateTime.parse("#{date} 12:00 +02:00")}
  Given{travel_to(now)}
  Given(:open_preschool){create :preschool, name: "A"}
  Given{
      create :hour,
            preschool: open_preschool,
            day_of_week: now.wday,
            opens: "08:00",
            closes: "16:00"
  }
  Given{create :site_change, preschool: open_preschool, state: :predicted, note: "prediction" }


  Given(:closed_preschool){create :preschool, name: "B"}
  Given{
      create :hour,
            preschool: closed_preschool,
            day_of_week: now.wday,
            opens: "08:00",
            closes: "11:00"
  }

  Given{create :site_change, preschool: closed_preschool, state: :active, note: "bye", updated_at: 2.hours.ago }
  Given{create :site_change, preschool: closed_preschool, state: :active, note: "ohhai", updated_at: 4.hours.ago }

  Given(:multiple_preschool){create :preschool, name: "C"}
  Given{
      create :hour,
            preschool: multiple_preschool,
            day_of_week: now.wday,
            opens: "08:00",
            closes: "11:00"
  }
  Given{
    create :hour,
          preschool: multiple_preschool,
          day_of_week: now.wday,
          opens: "13:00",
          closes: "16:00"
  }

  Given(:temp_closed_preschool){create :preschool, name: "D"}
  Given{
      create :hour,
            preschool: temp_closed_preschool,
            day_of_week: now.wday,
            opens: "08:00",
            closes: "13:00"
  }
  Given{
   create :temp_hour,
         preschool: temp_closed_preschool,
         opens_at: "#{date} 08:00",
         closes_at: "#{date} 11:00"
  }

  Given(:temp_opens_later_preschool){create :preschool, name: "E"}
  Given{
      create :hour,
            preschool: temp_opens_later_preschool,
            day_of_week: now.wday,
            opens: "08:00",
            closes: "13:00"
  }
  Given{
    create :temp_hour,
          preschool: temp_opens_later_preschool,
          opens_at: "#{date} 14:00",
          closes_at: "#{date} 15:00"
  }

  Given(:temp_closed_for_day_preschool){create :preschool, name: "F"}
  Given{
      create :hour,
            preschool: temp_closed_for_day_preschool,
            day_of_week: now.wday,
            opens: "08:00",
            closes: "13:00"
  }
  Given{
    create :temp_hour,
          preschool: temp_closed_for_day_preschool,
          opens_at: "#{date} 08:00",
          closes_at: "#{date} 10:00",
          closed_for_day: true
  }

  Given(:temp_open_preschool){create :preschool, name: "G"}
  Given{
      create :hour,
            preschool: temp_open_preschool,
            day_of_week: now.wday,
            opens: "13:00",
            closes: "17:00"
  }
  Given{
    create :temp_hour,
          preschool: temp_open_preschool,
          opens_at: "#{date} 11:00",
          closes_at: "#{date} 14:00"
  }

  describe "preschools" do
    When{}
    Then{
      # ap temp_opens_later_preschool.hours;
      # ap temp_opens_later_preschool.temp_hours;
      #ap subject.to_a#.find{|a| a.name == "G"}#.fourth;
      true
    }
    # Simple
    And{expect(subject.first.name).to eq "A"}
    And{expect(subject.first).to be_is_open}
    And{expect(subject.first).to_not be_closed_for_day}
    And{expect(subject.first).to have_changes}
    And{expect(subject.first.predicted_change_note).to eq "prediction"}
    And{expect(subject.first.active_change_note).to be_nil}

    # Temp, open
    And{expect(subject.second.name).to eq "G"}
    And{expect(subject.second).to be_is_open}
    And{expect(subject.second).to_not be_closed_for_day}
    And{expect(subject.second).to have_temp_hours}

    # Multiple, opens again
    And{expect(subject.third.name).to eq "C"}
    And{expect(subject.third).to_not be_closed_for_day}
    And{expect(subject.third).to_not be_is_open}
    And{expect(subject.third).to_not have_temp_hours}
    And{expect(subject.third.opens_again).to eq 1.hour.from_now}
    And{expect(subject.third.regular_opens_again).to eq 1.hour.from_now}
    And{expect(subject.third).to_not have_changes}

    # Closed, regular
    And{expect(subject.fourth.name).to eq "B"}
    And{expect(subject.fourth).to_not be_is_open}
    And{expect(subject.fourth).to be_closed_for_day}
    And{expect(subject.fourth).to be_regular_closed_for_day}
    And{expect(subject.fourth).to have_changes}
    And{expect(subject.fourth.active_change_note).to eq "bye"}
    And{expect(subject.fourth.predicted_change_note).to be_nil}

    # Opens later, temp
    And{expect(subject.fifth.name).to eq "E"}
    And{expect(subject.fifth).to_not be_is_open}
    And{expect(subject.fifth).to be_regular_is_open}
    And{expect(subject.fifth).to_not be_closed_for_day}
    And{expect(subject.fifth).to_not be_regular_closed_for_day}
    And{expect(subject.fifth.opens_again).to eq 2.hour.from_now}
    And{expect(subject.fifth.regular_opens_again).to be_nil}

    # Closed, temp
    And{expect(subject[5].name).to eq "D"}
    And{expect(subject[5]).to_not be_is_open}
    And{expect(subject[5]).to be_regular_is_open}
    And{expect(subject[5]).to be_closed_for_day}
    And{expect(subject[5]).to_not be_regular_closed_for_day}

    # Closed, temp for the day
    And{expect(subject[6].name).to eq "F"}
    And{expect(subject[6]).to_not be_is_open}
    And{expect(subject[6]).to be_regular_is_open}
    And{expect(subject[6]).to be_closed_for_day}
    And{expect(subject[6]).to_not be_regular_closed_for_day}

  end
end
