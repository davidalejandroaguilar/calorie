require "calorie/version"

require 'date'
require 'i18n'

require 'calorie/weeks_in_month'
require 'calorie/days_of_the_week'
require 'calorie/day_of_the_week'
require 'calorie/calendar'
require 'calorie/week'
require 'calorie/day'

I18n.config.enforce_available_locales = false

module Calorie

  class Config

    def initialize
      week_starts_on :sunday
    end

    def week_starts_on(day = nil)
      @week_starts_on = day if day
      @week_starts_on
    end

    def week_starts_on?(day)
      day == @week_starts_on
    end

    def show_padding_days(option = false)
      @show_padding_days = option
    end

    def show_padding_days?
      @show_padding_days
    end

  end

  class << self
    def configuration
      @config ||= Config.new

      yield @config if block_given?

      @config
    end

    def config=(configuration)
      @config = configuration
    end

    def new(year, month, data = {})
      Calendar.new(year, month, data)
    end

    def day_names
      @day_names ||= I18n.translate('calorie.days_of_the_week')
    end

    def month_names
      @month_names ||= I18n.translate('calorie.months')
    end

    def month_name(i)
      month_names[i-1]
    end
  end

end
