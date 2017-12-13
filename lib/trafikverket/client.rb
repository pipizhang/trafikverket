# coding: utf-8
require 'json'
require 'open3'

module Trafikverket

  class Client

    def initialize(curl_file)
      # verfiy curl file
      if !File.exist?(curl_file)
        raise RuntimeError.new("Not found file #{curl_file}")
      end
      @curl = File.read(curl_file).strip
      if !@curl.include? "curl" or !@curl.include? "Cookie"
        raise RuntimeError.new("Invalid curl file")
      end

      @occasions = []
    end

    def request
      reponse = ""
      ::Open3.popen3(@curl) do |stdin, stdout, stderr, wait_thr|
        reponse = stdout.read
        error = stderr.read
      end
      if !reponse
        return
      end
      _parse(reponse)
    end

    def _parse(content)
      begin
        # reset data
        @occasions = []

        json = JSON.parse(content)
        json['data'].each do |v|
          vv = v['occasions']
          tk = Examination.new(TEST_KNOWLEGE, vv[0]['date'], vv[0]['time'], vv[0]['locationName'])
          td = Examination.new(TEST_DRIVING, vv[1]['date'], vv[1]['time'], vv[1]['locationName'])
          @occasions.push({TEST_KNOWLEGE: tk, TEST_DRIVING: td})
        end
      rescue => e
        puts "parse error: #{e}"
      end
    end

    def get_all
      @occasions
    end

    def get_earlier_than(date)
      list = []
      @occasions.each do |v|
        list.push(v) if v.earlier_than(date)
      end
      return list
    end

    private :_parse

  end

end
