# coding: utf-8
require 'date'

module Trafikverket

  TEST_DRIVING  = "driving".freeze
  TEST_KNOWLEGE = "knowlege".freeze

  class Examination

    attr_accessor :date, :time, :location

    def initialize(type, date, time, location)
      @type = type
      @date = date
      @time = time
      @location = location
    end

    def earlier_than?(date)
      return false if @date.nil?
      date = Date.parse(date) if date.is_a?(String)
      Date.parse(@date) <= date
    end

    def info
      return "#{@date} #{@time} (#{@location})"
    end

    def in_weeks
      if @date.nil?
        days = 0
      else
        days = (Date.parse(@date) - Date.today).to_i
      end
      return (days.to_f / 7).ceil
    end

  end

end
