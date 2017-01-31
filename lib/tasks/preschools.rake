namespace :preschools do
  desc "Geocode that shit"
  task :geocode, [] => :environment do ||
    Preschool.where(position: nil).each do |preschool|
      # https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
      client = JsonClient.new(ENV['GOOGLE_GEOCODE_API_URL'])
      resp = client.get('', {address: preschool.address_params, key: ENV['GOOGLE_GEOCODE_API_KEY']})
      latitude, longitude = resp.body['results'].first['geometry']['location'].values_at('lat', 'lng')
      preschool.position = [latitude, longitude]
      preschool.save!
    end
  end
end
