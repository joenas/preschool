class ServiceRegistry
  def self.reset
    instance_variables.each do |instance_variable|
      instance_variable_set(instance_variable, nil)
    end
  end

  def self.classifier
    @classifier ||= begin
      ClassifierReborn::Bayes.new 'GoodSiteChange', 'BadSiteChange', backend: classifier_backend, language: 'sv'
    end
  end

  def self.classifier_backend
    Rails.env.test? ? ClassifierReborn::BayesMemoryBackend.new : ClassifierReborn::BayesRedisBackend.new
  end
end


Rails.application.config.to_prepare do
  ServiceRegistry.reset
end
