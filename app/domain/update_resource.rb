# TODO multiple listeners!
class UpdateResource
  attr_reader :params, :klass, :listener
  def initialize(klass:, params: {}, listener:)
    @klass, @params, @listener = klass, params, listener
  end

  def perform
    resource = klass.find(params[:id])
    resource.attributes = params.except('id')
    yield resource if block_given?
    result = resource.save ? :update_success : :update_failure
    listener.send(result, resource, params)
  end
end
