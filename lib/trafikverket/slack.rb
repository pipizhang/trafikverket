# coding: utf-8
require 'slack-ruby-client'

module Trafikverket

  class Slack

    def initialize(slack_token, channels=[])
      ::Slack.configure do |config|
          config.token = slack_token
      end
      @client = ::Slack::Web::Client.new
      @channels = parse_channels(channels)
      @name = "trafikverket-bot"
      @colors = {default: "#f0f0f0", green: "#2ab27b", blue: "#007AB8"}
      @footer = ""
    end

    def parse_channels(content)
      if content.is_a?(Array)
        return content
      end

      res = []
      if content.is_a?(String)
        content.split(",").each { |v|
          res << v.strip
        }
      end
      return res
    end

    def get_color(key)
      return @colors.keys.include?(key.to_sym) ? @colors[key.to_sym] : @colors[:default]
    end

    def post_text(msg)
      @channels.each do |ch|
        @client.chat_postMessage(
          channel: ch,
          username: @name,
          text: msg,
          mrkdwn: true
        )
      end
    end

    def post_message(title, text = '', color = nil, footer = '')
      @channels.each do |ch|
        @client.chat_postMessage(
          channel: ch,
          username: @name,
          attachments: [{
            title: title,
            text: text,
            color: get_color(color),
            footer: footer,
            ts: Time.now.to_i
          }]
        )
      end
    end

  end

end


