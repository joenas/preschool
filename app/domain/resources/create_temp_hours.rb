module Resources
  class CreateTempHours
    def initialize(params: {}, listeners: [])
      @params, @listeners = params, listeners
    end

    def perform
      preschool = Preschool.find(@params.fetch(:preschool_id))
      begin
        (start_date..end_date).each do |date|
          opens = "#{date} #{opens_at_time}"
          closes = "#{date} #{closes_at_time}"
          preschool.temp_hours.new(
            opens_at: opens,
            closes_at: closes,
            closed_for_day: closed_for_day
            )
        end
        result = preschool.save ? :create_success : :create_failure
      rescue InvalidDateError => e
        result = :create_failure
        preschool.errors.add(:base, "Invalid dates supplied")
      end
      Array(@listeners).each{|listener| listener.public_send(result, preschool, @params)}
    end

    private

    def start_date
      with_time_rescue { Date.parse(@params.fetch(:opens_at)) }
    end

    def end_date
      with_time_rescue { Date.parse(@params.fetch(:closes_at)) }
    end

    def opens_at_time
      with_time_rescue { Time.parse(@params.fetch(:opens_at)).strftime("%H:%M") }
    end

    def closes_at_time
      with_time_rescue { Time.parse(@params.fetch(:closes_at)).strftime("%H:%M") }
    end

    def closed_for_day
      @params.fetch(:closed_for_day)
    end

    def with_time_rescue
      begin
        yield
      rescue StandardError => e
        raise InvalidDateError
      end
    end

    class InvalidDateError < StandardError; end

  end
end
