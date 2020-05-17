module Calorie
  class Day

    attr_reader :date
    def initialize(date = nil, data = nil)
      @date = date
      @data = data
    end

    def weekend?
      @date.sunday? || @date.saturday?
    end

    def number
      @date.mday
    end

    def data
      @data
    end

    def blank?
      false
    end

    def today?
      @date == Date.today
    end

    def padding?
      false
    end
  end

  class NullDay
    attr_reader :date
    def initialize(date = nil)
      @date = date
    end

    def blank?
      true
    end

    def sunday?
      false
    end

    def saturday?
      false
    end

    def mday
    end

    def number
      if Calorie.configuration.show_padding_days?
        @date.mday
      else
        nil
      end
    end

    def data
    end

    def padding?
      true
    end
  end
end
