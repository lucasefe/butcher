require_relative 'response'
require 'curb'

module Butcher
  class Client

    attr_reader :source

    def initialize(source)
      @source = source
    end

    def get(path, parameters = nil)
      parameters ||= {}

      url = build_url(path)

      begin
        http = Curl.get(url, parameters) do |http|
          http.encoding = '' # allow compression, WTF
          apply_headers(http, request_headers)
        end

        raise ResourceNotFound if http.response_code == 404

        Response.new(http.header_str, http.body_str)

      rescue Curl::Err::ConnectionFailedError => e
        raise "Can't connect to #{source}: #{e.message}"
      rescue Exception => e
        raise "Failed connecting to #{url}: #{e}"
      end
    end

    def request_headers
      {
        'Accept' => 'application/json'
      }
    end

    private

    def build_url(path)
      "#{source}#{path}"
    end

    def apply_headers(http, headers)
      headers.each do |key, value|
        http.headers[key] = value
      end
    end

  end
end
