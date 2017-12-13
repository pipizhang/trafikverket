# coding: utf-8
require 'dotenv'

module Trafikverket

  module Config

    def self.init
      cfg_file = File.expand_path('../../../config/.env', __FILE__)

      if !File.exist?(cfg_file)
        # If the .env file doesn't exist, inform the user that they should create one.

        puts "Hey there! Not found a .env file in the current directory."
        puts ""
        puts "The 'config' folder included an example .env file, run this to use it:"
        puts ""
        puts "  cp env.example .env"
        puts ""
        puts "This will copy the \"env.example\" file to the \".env\" file."
        puts "Then update it with correct settings, run again."

        # Exit the program entirely
        exit
      end

      ::Dotenv.load cfg_file
    end

    def self.curl_file
      File.expand_path('../../../config/curl', __FILE__)
    end

  end

end

