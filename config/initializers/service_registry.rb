class ServiceRegistry
  def self.reset
    instance_variables.each do |instance_variable|
      instance_variable_set(instance_variable, nil)
    end
  end

  def self.classifier
    @classifier ||= begin
      redis_backend = ClassifierReborn::BayesRedisBackend.new
      ClassifierReborn::Bayes.new 'GoodSiteChange', 'BadSiteChange', backend: redis_backend, language: 'sv'
    end
  end
end


Rails.application.config.to_prepare do
  ServiceRegistry.reset
end
