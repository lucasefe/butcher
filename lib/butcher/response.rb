module Butcher
  class Response

    attr_reader :body_str, :header_str

    def initialize(header_str, body_str)
      @header_str = header_str
      @body_str = body_str
    end

    def body
      @body_str
    end

    def headers
      @headers ||= parse_headers
    end

    private

    def parse_headers
      http_headers = @header_str.split(/[\r\n]+/).map(&:strip)
      Hash[http_headers.flat_map { |s| s.scan(/^(\S+): (.+)/) } ]
    end
  end
end

