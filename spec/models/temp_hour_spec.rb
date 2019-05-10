require 'rails_helper'

describe TempHour do
  it{is_expected.to belong_to :preschool}

  it{is_expected.to validate_presence_of :preschool}
  it{is_expected.to validate_presence_of :opens_at}
  it{is_expected.to validate_presence_of :closes_at}

  it_behaves_like 'has a valid factory'

end
