require 'rails_helper'

describe SiteChange do
  it{is_expected.to belong_to :preschool}

  it{is_expected.to validate_presence_of :preschool}
  it{is_expected.to validate_presence_of :data}

  it{is_expected.to enumerize(:state).in(:new, :predicted, :active, :done)}

  it_behaves_like 'has a valid factory'

end
