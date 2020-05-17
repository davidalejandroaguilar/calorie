module Calorie

  class WeeksInMonth
    include Enumerable

    attr_reader :source_days
    def initialize(days = [])
      @source_days = days
    end

    def each
      weeks.each do |week|
        yield week
      end
    end

    def last
      weeks.last
    end

    def weeks
      unless @weeks
        @weeks = []
        padded_days = days_for_slicing
        number_of_weeks.times do
          @weeks << Calorie::Week.new(padded_days.slice!(0..6))
        end
      end
      @weeks
    end

    def days_for_slicing
      slices = source_days.clone

      (1..blank_days_at_start).each do |i|
        slices.unshift(Calorie::PaddingDay.new(first_day - i))
      end
      (1..blank_days_at_end).each do |i|
        slices.push(Calorie::PaddingDay.new(last_day + i))
      end

      slices
    end

    def blank_days_at_start
      first_day_falls_on
    end

    def blank_days_at_end
      7 - ((blank_days_at_start + days_in_month) % 7)
    end

    def number_of_weeks
      ((days_in_month + first_day_falls_on) / 7.0).ceil
    end

    def days_in_month
      source_days.length
    end

    def first_day
      source_days.first.date
    end

    def last_day
      source_days.last.date
    end

    def first_day_falls_on
      if Calorie.configuration.week_starts_on?(:monday)
        (first_day.wday - 1) % 7
      else
        first_day.wday
      end
    end
  end

end
