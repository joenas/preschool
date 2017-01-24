class Now < SimpleDelegator
  def initialize
    super Time.new(2000,01,01,Time.now.hour,Time.now.min,0,'+00:00').utc
  end
end
