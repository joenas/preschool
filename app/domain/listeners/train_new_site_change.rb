module Listeners
  class TrainNewSiteChange

    def update_success(site_change, params)
      return if site_change.previous_changes[:state] == %w{active done}
      original_text = site_change.extra_sanitized
      # TODO make command or whatever
      good = site_change.note.to_s.lines.map(&:strip)
      regex = good.join("|");
      bad = original_text.lines.reject{|str| str.match(/#{regex}/)};
      bad.each {|str| ServiceRegistry.classifier.train 'BadSiteChange', str.strip}
      good.each {|gd| ServiceRegistry.classifier.train 'GoodSiteChange', gd.strip}
    end

    def update_failure(*)
    end
  end
end
