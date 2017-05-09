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

  desc "Train the classifier"
  task :train_classifier, [] => :environment do ||
    texts = SiteChange.pluck("data -> 'extra'");
    sanitized = texts.flat_map {|text| Rails::Html::FullSanitizer.new.sanitize(text).gsub(/\s{2,}/,"\n").strip.lines};

    notes = SiteChange.where.not(note: nil).pluck(:note);
    good = notes.flat_map {|note| note.gsub(/\s{2,}/,"\n").strip.lines};

    regex = good.join("|");
    bad = sanitized.reject{|str| str.match(/#{regex}/)};

    bad.each {|str| ServiceRegistry.classifier.train 'BadSiteChange', str.strip}
    good.each {|gd| ServiceRegistry.classifier.train 'GoodSiteChange', gd.strip}
  end
end
