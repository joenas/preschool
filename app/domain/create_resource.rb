class CreateResource
  def initialize(klass:, params: {}, listener:)
    @klass, @params, @listener = klass, params, listener
  end

  def perform
    resource = @klass.new(@params) do |res|
      yield res if block_given?
    end
    result = resource.save ? :create_success : :create_failure
    @listener.send(result, resource, @params)
  end
end
