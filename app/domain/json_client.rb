class JsonClient < SimpleDelegator

  def initialize(url, &block)
    @url = url
    super client(&block)
  end

  def client
    Faraday.new @url do |connection|
      yield connection if block_given?
      connection.request :json
      connection.response :json, content_type: 'application/json'
      connection.adapter Faraday.default_adapter
    end
  end
end
