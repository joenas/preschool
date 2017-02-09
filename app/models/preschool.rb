class Preschool < ActiveRecord::Base

  # TODO to get rid of warnings, change to attribute :position, :point
  attribute :position, :legacy_point

  has_many :hours
  has_many :site_changes

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :street_name
  validates_presence_of :postal_code
  validates_presence_of :city

  def address_params
    URI.escape(attributes.slice('street_name', 'postal_code', 'city').values.join(', ') << ",Sweden")
  end

  def active_site_change
    site_changes.where(state: :active).first
  end

  def to_json_ld
    {

      "@context" => "http://schema.org",
      "@type" => "Preschool",
      "url" => url,
      "name" => name,
      "address" => {
        "@type" => "PostalAddress",
        "addressLocality" => city,
        "postalCode" => postal_code,
        "streetAddress" => street_name
      },
      #"openingHoursSpecification" => hours.map(&:to_json_ld)
    }
  end

end
