require_relative 'client'
require 'curb'

module Butcher
  class Client

    Response = Struct.new(:headers, :body)

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

        headers = headers_from_response http

        Response.new(headers, http.body_str)

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

    def headers_from_response(response)
      http_headers = response.header_str.split(/[\r\n]+/).map(&:strip)
      Hash[http_headers.flat_map { |s| s.scan(/^(\S+): (.+)/) } ]
    end

    def apply_headers(http, headers)
      headers.each do |key, value|
        http.headers[key] = value
      end
    end

  end
end
