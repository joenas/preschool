require 'rails_helper'

describe Preschool do
  it{is_expected.to have_many :hours}
  it{is_expected.to have_many :site_changes}
  it{is_expected.to have_many :urls}

  it{is_expected.to validate_presence_of :name}
  it{is_expected.to validate_presence_of :url}
  it{is_expected.to validate_presence_of :street_name}
  it{is_expected.to validate_presence_of :postal_code}
  it{is_expected.to validate_presence_of :city}

  it_behaves_like 'has a valid factory'

end
