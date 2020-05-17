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

  class PaddingDay < Day
    def blank?
      if Calorie.configuration.show_padding_days?
        false
      else
        true
      end
    end

    def number
      if Calorie.configuration.show_padding_days?
        @date.mday
      else
        nil
      end
    end

    def padding?
      true
    end
  end
end
