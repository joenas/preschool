class CreateResource
  def initialize(klass:, params: {}, listeners: [])
    @klass, @params, @listeners = klass, params, listeners
  end

  def perform
    resource = @klass.new(@params) do |res|
      yield res if block_given?
    end
    result = resource.save ? :create_success : :create_failure
    Array(@listeners).each{|listener| listener.public_send(result, resource, @params)}
  end
end
