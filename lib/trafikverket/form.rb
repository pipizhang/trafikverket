# coding: utf-8
require 'json'

module Trafikverket

  class BokaForm

    VAR_LICENCE_B = 5

    VAR_LANG_ENGLISH = 4
    VAR_LANG_SWEDISH = 13

    VAR_VEHICLE_AUTO = 4
    VAR_VEHICLE_MANUAL = 2

    VAR_LOCATION_STOCKHOLM = 1000140
    VAR_LOCATION_JAKOBSBERG = 1000141
    VAR_LOCATION_SOLLENTUNA = 1000134
    VAR_LOCATION_FARSTA = 1000019

    def initialize
      @data = {bookingSession: {}, occasionBundleQuery: {}}
    end

    def get_person_id(str)
      if !str.match? /^\d{8}[\-]{0,1}\d{4}$/
        raise RuntimeError.new "Invalid person id number(format example '19990101-0001')"
      end

      if str.include? "-"
        return str
      else
        "#{str[0..7]}-#{str[8..-1]}"
      end
    end

    def populate(person_id, location, language, vehicle)
      start_date = Time.now.strftime "%Y-%m-%dT%H:%M:%SZ"
      person_id = get_person_id(person_id)

      @data[:bookingSession] = {
        socialSecurityNumber: person_id,
        licenceId: VAR_LICENCE_B,
        bookingModeId: 0,
        ignoreDebt: false,
        examinationTypeId: 0,
        rescheduleTypeId: 0
      }

      @data[:occasionBundleQuery] = {
        startDate: start_date,
        locationId: location,
        languageId: language,
        vehicleTypeId: vehicle,
        tachographTypeId: 1,
        occasionChoiceId: 1,
        examinationTypeId: 0
      }

      self
    end

    def to_json
      @data.to_json
    end

  end

end

