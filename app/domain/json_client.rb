class JsonClient < SimpleDelegator

  def initialize(url)
    @url = url
    super client
  end

  def client
    Faraday.new @url do |connection|
      connection.request :json
      connection.response :json
      connection.adapter Faraday.default_adapter
    end
  end
end
