class HtmlClient < SimpleDelegator

  def initialize(url, &block)
    @url = url
    super client(&block)
  end

  def client
    Faraday.new @url do |connection|
      yield connection if block_given?
      connection.use Faraday::Response::RaiseError
      connection.adapter Faraday.default_adapter
    end
  end
end
