class UpdateResource
  attr_reader :params, :klass, :listeners
  def initialize(klass:, params: {}, listeners: [])
    @klass, @params, @listeners = klass, params, listeners
  end

  def perform
    resource = klass.find(params[:id])
    resource.attributes = params.except('id')
    yield resource if block_given?
    result = resource.save ? :update_success : :update_failure
    Array(listeners).each{|listener| listener.public_send(result, resource, params)}
  end
end
