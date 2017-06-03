require 'rails_helper'

describe Hour do
  it{is_expected.to belong_to :preschool}

  it{is_expected.to validate_presence_of :preschool}
  it{is_expected.to validate_presence_of :day_of_week}
  it{is_expected.to validate_presence_of :opens}
  it{is_expected.to validate_presence_of :closes}

  #it_behaves_like 'has a valid factory'

end
