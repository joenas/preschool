namespace :preschools do
  desc "Geocode that shit"
  task :geocode, [] => :environment do ||
    Preschool.where(position: nil).each do |preschool|
      # https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
      client = Client.new
      resp = client.get('', {address: preschool.address_params})
      latitude, longitude = resp.body['results'].first['geometry']['location'].values_at('lat', 'lng')
      preschool.position = [latitude, longitude]
      preschool.save!
    end
  end
end

class Client < SimpleDelegator

  def initialize
    super client
  end

  private

  def base_url
    "https://maps.googleapis.com/maps/api/geocode/json?"
  end

  def client
    Faraday.new base_url, {params: {key: ENV['GOOGLE_GEOCODE_API_KEY']}} do |connection|
      connection.request :json
      connection.response :json
      connection.adapter Faraday.default_adapter
    end
  end
end
