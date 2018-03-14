# coding: utf-8
require 'json'
require 'open3'
require 'excon'

module Trafikverket

  class Client

    def initialize(user_agent)
      @occasions = []
      @endpoint = "https://fp.trafikverket.se/Boka/occasion-bundles"
      @user_agent = user_agent
    end

    def request(post_data)
      raw = ""
      begin
        response = Excon.post(
          @endpoint,
          :body => post_data,
          :headers => {
            "Content-Type" => "application/json",
            "X-Requested-With" => "XMLHttpRequest",
            "User-Agent" => @user_agent
          }
        )
        if response.status == 200
          raw = response.body
        else
          raise RuntimeError.new "Remote Server returns #{response.status}"
        end
      rescue => e
        puts "[ERROR] http request error: #{e}"
      end

      _parse(raw) if raw != ""
    end

    def _parse(content)
      begin
        # reset data
        @occasions = []

        json = JSON.parse(content)

        if json['status'] != 200
          raise RuntimeError.new "Server return #{json['status']}, plsease check your input"
        end

        json['data'].each do |v|
          td = Examination.new(TEST_DRIVING, nil, nil, nil)
          tk = Examination.new(TEST_KNOWLEGE, nil, nil, nil)

          v['occasions'].each do |vv|
            if vv['name'].include? "Körprov"
              td = Examination.new(TEST_DRIVING, vv['date'], vv['time'], vv['locationName'])
            else
              tk = Examination.new(TEST_KNOWLEGE, vv['date'], vv['time'], vv['locationName'])
            end
          end
          @occasions.push({TEST_KNOWLEGE: tk, TEST_DRIVING: td})
        end

      rescue => e
        puts "[ERROR] parse error: #{e}"
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
